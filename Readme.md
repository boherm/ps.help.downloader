# PrestaShop help documentation downloader
## What is it?
This tools aim to download and prepare all the documentation from the old help.prestashop.com website in function of langs, versions and controllers configured.

**Bonus:** We can also start a nginx server to test the documentation locally.

## How to use it?
1. Clone the repository.
2. Modify all config files in `config` folder if you need to retrieve only just a part of it.
3. Run `make` to download all the documentation.
4. Run `make serve` to start a nginx server to test the documentation locally.

## What we retrieve?
By default, we retrieve all the documentation for:
- de, en, es, fr, it, nl, pl (`config/langs`)
- 1.6, 1.7, 8.0, 8.1 (`config/versions`)
- all controllers in `config/controllers`
