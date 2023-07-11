import puppeteer from 'puppeteer';
// const puppeteer = await import('puppeteer')

import actions from './src/actions.mjs';
import { sleep } from './src/utils.mjs';
import { wordList } from './src/word-list-small.mjs';

(async () => {
  const browser = await puppeteer.launch({headless: false}); // headless values: false or 'new'
  const page = await browser.newPage();

  await page.goto('https://www.nytimes.com/games/wordle/index.html');

  await page.locator('button[data-testid="Play"]').click();
  await page.locator('button[aria-label="Close"]').click();

  function randomWord(wordList) {
    return wordList[Math.floor(Math.random() * wordList.length)];
  }

  let word = randomWord(wordList);
  console.log(word);
  await actions.submitWord(page, word);
  word = randomWord(wordList);
  console.log(word);
  await actions.submitWord(page, word);
  word = randomWord(wordList);
  console.log(word);
  await actions.submitWord(page, word);
  word = randomWord(wordList);
  console.log(word);
  await actions.submitWord(page, word);
  word = randomWord(wordList);
  console.log(word);
  await actions.submitWord(page, word);
  word = randomWord(wordList);
  console.log(word);
  await actions.submitWord(page, word);

  await sleep(10_000);

  await browser.close();
})();
