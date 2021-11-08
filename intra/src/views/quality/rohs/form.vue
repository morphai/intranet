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
          <v-text-field v-model="form.title" outlined label="Maker" required></v-text-field>
          <v-text-field v-model="form.grade" outlined label="Grade" required></v-text-field>
          <v-text-field v-model="form.color" outlined label="Color" required></v-text-field>
          <v-text-field v-model="form.category" outlined label="category" required></v-text-field>
          <v-text-field type="date" v-model="form.issueDate" outlined label="발행일자" required></v-text-field>
          <v-text-field type="date" v-model="form.expirationDate" outlined label="유효일자"> required</v-text-field>
          <v-text-field v-model="form.certificationAuth" outlined label="발행기관"> required</v-text-field>
          <v-text-field v-model="form.dataSheet" outlined label="File"> required</v-text-field>
        </v-card-text>
      </v-card>
    </v-form>
  </v-container>
</template>
<script>
export default {
  props: ['document', 'action'],
  data () {
    return {
      form: {
        title: '',
        grade: '',
        color: '',
        category: '',
        issueDate: '',
        expirationDate: '',
        certificationAuth: '',
        dataSheet: ''
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
      this.form.grade = item.grade
      this.form.color = item.color
      this.form.category = item.category
      this.form.issueDate = item.issueDate
      this.form.expirationDate = item.expirationDate
      this.form.certificationAuth = item.certificationAuth
      this.form.dataSheet = item.dataSheet
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const doc = {
          title: this.form.title,
          grade: this.form.grade,
          color: this.form.color,
          category: this.form.category,
          issueDate: this.form.issueDate,
          expirationDate: this.form.expirationDate,
          certificationAuth: this.form.certificationAuth,
          dataSheet: this.form.dataSheet,
          updatedAt: createdAt
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
        this.loading = false
        this.$router.push('/quality/' + this.document)
      }
    }
  }
}
</script>
<!-- maker를 타이틀로 변경(사유: display-quality-firestore를 공용 title로 사용하기 위함) -->
