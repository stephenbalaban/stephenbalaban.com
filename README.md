# Stephen's Make static site generator

## To install dependencies (pandoc, make, awscli, rsync)

```
sudo apt-get install -y build-essential pandoc awscli rsync
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
