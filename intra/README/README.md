# intra

# install

## firebase use

```bash
$ firebase login # If you are not logged in
$ firebase use --add
? Which project do you want to add? xxx-site
? What alias do you want to use for this project? (e.g. staging) default

Created alias default for xxx-site.
Now using alias default (xxx-site)
```

## functions

### key download

functions/key.json download from console service account key

### setting

```bash
$ firebase functions:config:set admin.email=xx@abc.com admin.db_url=https://shinwhaintranet-default-rtdb.firebaseio.com
```

## hosting

### Dependecies install

Dependencies installation

```bash
$ yarn # front-end install
$ cd functions && yarn # back-end install
$ cd ..
```

## 신규인원 추가시 수정사항

```bash
$ 1. display-user.vue : 2가지 추가
$ 2. App.vue : 1가지 추가
$ cd ..
```

## node version

v16.20.2
