<template>
  <v-container fluid>
    <v-form>
      <v-card :loading="loading">
        <v-toolbar color="primary" dark dense>
          <v-toolbar-title>게시판 글 작성</v-toolbar-title>
        <v-spacer/>
        <v-btn icon @click="$router.push('/quality/' + document)"><v-icon>mdi-arrow-left</v-icon></v-btn>
        <v-btn icon @click="save" :disabled="!user"><v-icon>mdi-content-save</v-icon></v-btn>
        </v-toolbar>
        <v-card-text>
          <v-text-field v-model="form.title" outlined label="문서명" required></v-text-field>
          <v-text-field v-model="form.docNo" outlined label="문서번호" required></v-text-field>
          <editor v-if="!articleId" :initialValue="form.content" ref="editor" initialEditType="wysiwyg" height="650px" :options="{ hideModeSwitch: true}"></editor>
          <template v-else>
            <editor v-if="form.content" :initialValue="form.content" ref="editor" initialEditType="wysiwyg" height="650px" :options="{ hideModeSwitch: true}"></editor>
            <v-container v-else>
              <v-row justify="center" align="center">
                <v-progress-circular indeterminate></v-progress-circular>
              </v-row>
            </v-container>
          </template>
        </v-card-text>
      </v-card>
    </v-form>
  </v-container>
</template>
<script>
import axios from 'axios'
export default {
  props: ['document', 'action'],
  data () {
    return {
      form: {
        title: '',
        docNo: '',
        content: ''
      },
      exists: false,
      loading: false,
      ref: null
    }
  },
  computed: {
    articleId () {
      return this.$route.query.articleId
    },
    user () {
      return this.$store.state.user
    }
  },
  watch: {
    document () {
      this.fetch()
    }
  },
  created () {
    this.fetch()
  },
  destroyed () {
  },
  methods: {
    async fetch () {
      this.ref = this.$firebase.firestore().collection('quality').doc(this.document)
      if (!this.articleId) return
      const doc = await this.ref.collection('articles').doc(this.articleId).get()
      this.exists = doc.exists
      if (!this.exists) return
      const item = doc.data()
      this.form.title = item.title
      this.form.docNo = item.docNo
      const { data } = await axios.get(item.url)
      this.form.content = data
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const md = this.$refs.editor.invoke('getMarkdown')
        const sn = await this.$firebase.storage().ref().child('quality').child(this.document).child(!this.articleId ? id + '.md' : this.articleId + '.md').putString(md)
        // storage overwrite 불가 문제로 삼항 연산자 적용 (추후 동작 확인필요)
        const url = await sn.ref.getDownloadURL()
        const doc = {
          title: this.form.title,
          docNo: this.form.docNo,
          updatedAt: createdAt,
          url: url
        }
        const batch = await this.$firebase.firestore().batch()
        if (!this.articleId) {
          doc.createdAt = createdAt
          doc.commentCount = 0
          doc.readCount = 0
          doc.uid = this.$store.state.fireUser.uid
          doc.user = {
            email: this.user.email,
            photoURL: this.user.photoURL,
            displayName: this.user.displayName
          }
          batch.set(this.ref.collection('articles').doc(id), doc)
          batch.update(this.ref, { count: this.$firebase.firestore.FieldValue.increment(1) })
        } else {
          batch.update(this.ref.collection('articles').doc(this.articleId), doc)
        }
        await batch.commit()
      } finally {
        console.log(this.id)
        this.loading = false
        this.$router.push('/quality/' + this.document)
      }
    }
  }
}
</script>
