import { sleep } from './utils.mjs';

async function submitWord(page, word) {
  const letters = word.split('');
  for (const letter of letters) {
    await page.locator(`button[data-key="${letter}"]`).click();
  }
  await page.locator(`button[data-key="↵"]`).click();
  await page.waitForSelector('[data-state="tbd"]', { hidden: true });
  await sleep(176);
}

export default { submitWord }
