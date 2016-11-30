var casper = require('casper').create();

casper.start('http://www.salvatorecordiano.it', function() {
    this.echo(this.getTitle());
});

casper.run();
