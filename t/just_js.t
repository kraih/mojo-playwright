#!/usr/bin/env node
const starter = require('@mojolicious/server-starter')
const tap = require('tap')
const { chromium } = require('playwright')

async function test () {
  const server = await starter.newServer()
  await server.launch('perl', ['chat.pl', 'daemon', '-m', 'production', '-l', 'http://*?fd=3'])
  const browser = await chromium.launch()
  const context = await browser.newContext()
  const page = await context.newPage()
  const url = server.url()

  await page.goto(url)
  const firstTitle = await page.innerText('title')
  tap.equal(firstTitle, 'Welcome')
  await page.click('text=Chat')
  tap.equal(page.url(), url + '/chat')
  const secondTitle = await page.innerText('title')
  tap.equal(secondTitle, 'Chat')
  await page.click('input[type="text"]')
  await page.fill('input[type="text"]', 'test')
  await page.click('text=Send')
  await page.click('input[type="text"]')
  await page.fill('input[type="text"]', '123')
  await page.press('input[type="text"]', 'Enter')
  const firstMessage = await page.innerText('#messages p:nth-of-type(1)')
  tap.equal(firstMessage, 'test')
  const secondMessage = await page.innerText('#messages p:nth-of-type(2)')
  tap.equal(secondMessage, '123')

  await context.close()
  await browser.close()
  await server.close()
}

test()
