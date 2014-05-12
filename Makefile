all: .images.reesd.com.noteed.bup

.images.reesd.com.noteed.bup-builder: Dockerfile prepare.sh
	docker build -t images.reesd.com/noteed/bup-builder .
	touch .images.reesd.com.noteed.bup-builder

.images.reesd.com.noteed.bup: .images.reesd.com.noteed.bup-builder
	docker run --cidfile .cid -d --privileged images.reesd.com/noteed/bup-builder sh /prepare.sh
	docker wait `cat .cid`
	docker commit `cat .cid` images.reesd.com/noteed/bup
	rm .cid
	touch .images.reesd.com.noteed.bup

run: .images.reesd.com.noteed.bup
	docker run -v `pwd`:/source -t -i images.reesd.com/noteed/bup sh /source/script.sh
