import puppeteer from 'puppeteer';
// const puppeteer = await import('puppeteer')

import actions from './src/actions.mjs'
import { sleep } from './src/utils.mjs';

(async () => {
  const browser = await puppeteer.launch({headless: false}); // headless values: false or 'new'
  const page = await browser.newPage();

  await page.goto('https://www.nytimes.com/games/wordle/index.html');

  await page.locator('button[data-testid="Play"]').click();
  await page.locator('button[aria-label="Close"]').click();

  await actions.submitWord(page, 'crane');
  await actions.submitWord(page, 'lousy');
  await actions.submitWord(page, 'fight');
  await actions.submitWord(page, 'break');
  await actions.submitWord(page, 'kazoo');
  await actions.submitWord(page, 'dream');

  await sleep(10000);

  await browser.close();
})();
