# New Feed Blogs

## Requirements

- Ruby
- Selenium
- NodeJS
- Pug

## Installation

```bash
# install selenium gem
# you need install the driver for browser too. In my case
# I use firefox, so I install geckodriver
$ gem install selenium-webdriver

# install node dependencies
$ npm install
```

## How to use

```bash
# retrive new articles for the configured blogs
$ ruby app.rb

# run the serve to see the result
$ node index.js # or nodemon

# go to http://localhost:2000/
```

## How it was done

I set up just two blogs. They are mapped in the `blogs.json` file. When the ruby script is executed, it is checked the last time it was executed, to retrieve the five articles written since that date. The result is saved to `blogs.json`. 

When index.js is run, a view is created, using the Pug model, based on articles saved on `blogs.json`.
