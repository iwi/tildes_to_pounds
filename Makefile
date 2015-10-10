run:
	docker run --rm -it \
		-v $(PWD):/source \
		-w /source \
		ruby ruby tildes_to_pounds.rb
