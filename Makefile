.PHONY: check clean

check:
	rocq compile TrustedMetatheory.v

clean:
	rm -f TrustedMetatheory.glob TrustedMetatheory.vo TrustedMetatheory.vok TrustedMetatheory.vos
