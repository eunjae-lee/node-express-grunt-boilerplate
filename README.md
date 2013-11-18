# node-express-boilerplate

A boilerplate to start a new express project based on CoffeeScript, Grunt build system, forever runner, Jade Template and bootstrap.



## Usage

### Preparing
    git clone git@github.com:eunjae-lee/node-express-boilerplate.git
    cd node-express-boilerplate
	npm install
	
### Starting Server
	npm start
	
### Stopping Server
    npm stop

## Folder Tree
    public
        assets
        images
        javascripts
        coffeescripts
        stylesheets
        less
    routes
	views

## More Guide
Basically files under "public" folder are copied, minified or converted to "public_built" folder, and node app's static path is set to "public_built".

* Files under the following folders will be just copied to /public_built
  * public/assets
  * public/images
    * To compress images, run "grunt imagecomp"
  * public/javascripts
  * public/stylesheets
* Files under "public/coffeescripts" will be converted to "\*.js" and "\*.min.js" at "/public_built/javascripts"
* Files under "public/less" will be converted to "\*.css" and "\*.min.css" at "/public_built/stylesheets"

## License
[MIT](http://opensource.org/licenses/mit-license.html)