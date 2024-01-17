#!/bin/sh

for f in $(ls ./config)
do
	mkdir -p $f
	ln -rs ./config/$f/* ~/.config/$f/*
done

ln -rs ./.{x,z}* ~/*
