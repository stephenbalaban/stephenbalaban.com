# Stephen's blog repository

## To install dependencies (pandoc, make, awscli)

```
sudo apt-get install -y build-essential pandoc awscli
```

## To configure your awscli

```
aws configure
```

## To deploy

```
make
make upload
```

## To clean

```
make clean
```

## To modify the pandoc template

Edit `template.html`.

## To modify the table of contents on the index

Edit `generate_index.sh`.
