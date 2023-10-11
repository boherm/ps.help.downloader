# Build documentation
build:
	- sh build.sh

# Clear public folder
clear:
	- rm -rf dist/

# Start nginx server
serve:
	- docker run --rm --name pretaHelp -v `pwd`/nginx.conf:/etc/nginx/nginx.conf:ro -v `pwd`/dist:/usr/share/nginx/html:ro -p 8080:80 nginx

# Build documentation and start nginx server
build-serve: build serve
