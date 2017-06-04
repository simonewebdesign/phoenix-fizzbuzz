# FizzBuzz

A Phoenix application.

## Getting started

You need to have Elixir 1.4.x installed on your machine.

To start the Phoenix server:

    mix deps.get
    mix phx.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

You can also run the app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server

To run the tests:

    mix test

## Walk-through

The relevant files are:

- [`lib/fizzbuzz.ex`](https://github.com/simonewebdesign/phoenix-fizzbuzz/blob/master/lib/fizzbuzz.ex): fizzbuzz implementation.
- [`lib/fizzbuzz/item.ex`](https://github.com/simonewebdesign/phoenix-fizzbuzz/blob/master/lib/fizzbuzz/item.ex): model.
- [`lib/fizzbuzz/web/controllers/page_controller.ex`](https://github.com/simonewebdesign/phoenix-fizzbuzz/blob/master/lib/fizzbuzz/web/controllers/page_controller.ex): controller.
- [`lib/fizzbuzz/web/templates/page/index.html.eex`](https://github.com/simonewebdesign/phoenix-fizzbuzz/blob/master/lib/fizzbuzz/web/templates/page/index.html.eex): view template.
- [`priv/static/js/app.js`](https://github.com/simonewebdesign/phoenix-fizzbuzz/blob/master/priv/static/js/app.js): web client.

There is one single entry-point, which is [`localhost:4000`](http://localhost:4000). It's not a SPA, although it's quite close to being one. Marking favourites doesn't require a page reload because it's using websockets.

The `PageController`'s `index` function is taking care of paginating the results and serving them in either HTML or JSON, depending on the client request.

The number of values displayed defaults to 100 per page and the limit is capped at 100,000,000,000 results. However it is possible to go even further and display extremely big values (you can do so by incrementing the querystring's `page` parameter).

Even with huge values, the server remains very fast and responsive. There is no caching layer, but the favourites are saved in an ETS table, which is an in-memory storage – that's why it's so fast: it's never going to write to disk. This also means that when we restart the server we lose the data, but I decided to use it anyway because:

- MySQL or PostgreSQL felt overkill for a fizzbuzz app;
- ETS is simple and does the job;
- I wanted to learn how it works.

On a real-world app I would probably choose to use Ecto with PostgreSQL or equivalent. My primary goal was to "Keep It Simple, Stupid" (KISS).

For the JSON API you can just add `json` to the querystring, i.e. [`localhost:4000/?json`](http://localhost:4000/?json). The pagination works the same way.
