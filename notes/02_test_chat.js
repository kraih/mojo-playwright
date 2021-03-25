import { strict as assert } from 'assert'
import { chromium } from 'playwright';

(async () => {
  const browser = await chromium.launch()
  const context = await browser.newContext()
  const page = await context.newPage()

  await page.goto('http://127.0.0.1:3000/')
  await page.click('text=Chat')
  assert.equal(page.url(), 'http://127.0.0.1:3000/chat')
  await page.click('input[type="text"]')
  await page.fill('input[type="text"]', 'test')
  await page.click('text=Send')
  await page.click('input[type="text"]')
  await page.fill('input[type="text"]', '123')
  await page.press('input[type="text"]', 'Enter')
  const firstMessage = await page.innerText('#messages p:nth-of-type(1)')
  assert.equal(firstMessage, 'test')
  const secondMessage = await page.innerText('#messages p:nth-of-type(2)')
  assert.equal(secondMessage, '123')

  await context.close()
  await browser.close()
})()
