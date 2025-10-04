// update-vscode-theme.mjs
import { createTheme, createVsCodeTheme, themeOptions } from 'material-code/theme';
import { readdir, readFile, writeFile } from 'node:fs/promises';
import path from 'path';
import os from 'os';

const HOME = os.homedir();

// возможные пути, где Matugen / pywal может писать JSON — проверим по порядку
const candidates = [
  path.join(HOME, '.config/system-ui/app-data.json'),
  path.join(HOME, '.cache/wal/colors.json'),
  path.join(HOME, '.cache/matugen/colors.json'),
  path.join(HOME, '.config/matugen/colors.json'),
  path.join(HOME, '.config/matugen/output.json')
];

async function findSystemFile() {
  for (const p of candidates) {
    try {
      const s = await readFile(p, 'utf8');
      return { path: p, json: JSON.parse(s) };
    } catch(e) {
      // ignore
    }
  }
  return null;
}

function pickPrimary(systemTheme) {
  // пробуем несколько полей, которые чаще встречаются
  return (
    systemTheme.primary ||
    systemTheme.colors?.primary?.default?.hex ||
    systemTheme.colors?.primary ||
    systemTheme.primary?.hex ||
    systemTheme.accent ||
    systemTheme.colors?.color1 ||
    systemTheme.colors?.color0 ||
    '#6200EE'
  );
}

function pickDarkMode(systemTheme) {
  if (typeof systemTheme.darkMode === 'boolean') return systemTheme.darkMode;
  if (systemTheme.mode === 'dark' || systemTheme.scheme === 'dark') return true;
  if (systemTheme.mode === 'light' || systemTheme.scheme === 'light') return false;
  return false;
}

async function findExtensionBuildDir() {
  const tryDirs = [
    path.join(HOME, '.vscode/extensions'),
    path.join(HOME, '.vscode-insiders/extensions')
  ];
  for (const base of tryDirs) {
    try {
      const list = await readdir(base);
      const target = list.find(d => d.includes('material-code'));
      if (target) return path.join(base, target, 'build');
    } catch(e) {
      // ignore
    }
  }
  return null;
}

(async () => {
  const sys = await findSystemFile();
  if (!sys) {
    console.error('Не найден JSON от Matugen/pywal. Сгенерируй его и укажи путь в candidates в скрипте.');
    process.exit(2);
  }
  console.log('Нашёл файл:', sys.path);

  const primary = pickPrimary(sys.json);
  const darkMode = pickDarkMode(sys.json);

  console.log('primary ->', primary, 'darkMode ->', darkMode);

  const theme = createTheme({
    ...themeOptions,
    darkMode,
    primary
    // при желании можно подставить больше полей (accent, onPrimary и т.д.)
  });

  const vscodeTheme = createVsCodeTheme(theme);

  const buildDir = await findExtensionBuildDir();
  if (!buildDir) {
    console.error('Не удалось найти папку расширения material-code в ~/.vscode/extensions или ~/.vscode-insiders/extensions');
    process.exit(3);
  }

  const outPath = path.join(buildDir, 'dark.json');
  await writeFile(outPath, JSON.stringify(vscodeTheme, null, 2), 'utf8');
  console.log('Записал тему в', outPath);
  console.log('Перезапусти VS Code или переключи тему на Material Code → тёмная, затем нажми "Reload Window".');
})();
