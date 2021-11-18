#!/bin/bash

domain=$1

mkdir -p $domain $domain/assetfinder $domain/waybackurls $domain/GF $domain/dalfox $domain/httpx

assetfinder_fun(){
assetfinder $domain --subs-only  | tee -a $domain/assetfinder/assetfinder_link | anew
}
assetfinder_fun

waybackurls_fun(){
cat $domain/assetfinder/assetfinder_link | waybackurls | anew | tee -a $domain/waybackurls/waybackurls_link
cat $domain/waybackurls/waybackurls_link | egrep -V ".woff|.ttf|.svg|.eot|.png|.jpeg|.jpg|.svg|.css|.ico|.gif" > $domain/waybackurls/waybackurls_link 
}
waybackurls_fun

httpx_fun(){
cat $domain/waybackurls/waybackurls_link | httpx -mc 200 | tee -a $domain/waybackurls/httpx_link
}
httpx_fun

GF_fun(){
cat $domain/httpx/httpx_link | GF xss | tee -a $domain/GF/gf_xss
}
GF_fun

dalfox_fun(){
cat $domain/GF/gf_xss | dalfox pipe --mass-worker 50  | tee -a $domain/dalfox/dalfox_links
}
dalfox_fun
