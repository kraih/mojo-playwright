import { strict as assert } from 'assert'
import { chromium } from 'playwright';

(async () => {
  const browser = await chromium.launch({ headless: false })
  const context = await browser.newContext()
  const page = await context.newPage()

  await page.goto('https://mojolicious.org/')
  await page.click('text=Documentation')
  await page.click('text=Tutorial')
  assert.equal(page.url(), 'https://docs.mojolicious.org/Mojolicious/Guides/Tutorial')
  await page.screenshot({ path: 'tutorial.png' })

  await context.close()
  await browser.close()
})()
