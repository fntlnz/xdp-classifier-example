.PHONY: tcbuild tcload tcunload

IFNAME?=eth0

tcbuild:
	clang -O2 -target bpf -c xdp-classifier.c -o xdp-classifier.o

tcload: tcbuild
	sudo tc qdisc add dev $(IFNAME)  handle 0: ingress
	sudo tc filter add dev $(IFNAME) ingress  bpf obj xdp-classifier.o flowid 0:

tcunload:
	sudo tc qdisc del dev $(IFNAME) ingress
