<template>
  <v-container fluid>
    <v-form>
      <v-card :loading="loading">
        <v-toolbar defect="primary" dark dense>
          <v-toolbar-title>게시판 글 작성</v-toolbar-title>
        <v-spacer/>
        <v-btn icon @click="$router.push('/quality/' + document)"><v-icon>mdi-arrow-left</v-icon></v-btn>
        <v-btn icon @click="save" :disabled="!user"><v-icon>mdi-content-save</v-icon></v-btn>
        </v-toolbar>
        <v-card-text>
          <v-text-field v-model="form.title" outlined label="성명" required></v-text-field>
          <v-text-field v-model="form.position" outlined label="직위" required></v-text-field>
          <v-text-field v-model="form.task" outlined label="업무명" required></v-text-field>
          <v-text-field type="date" v-model="form.entryDate" outlined label="입사일" required></v-text-field>
          <v-text-field type="date" v-model="form.startDate" outlined label="업무시작일" required></v-text-field>
          <v-text-field v-model="form.career" outlined label="경력" required></v-text-field>
          <v-text-field v-model="form.dataSheet" outlined label="문서 File"> required</v-text-field>
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
        position: '',
        task: '',
        entryDate: '',
        startDate: '',
        career: '',
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
      this.form.position = item.position
      this.form.task = item.task
      this.form.entryDate = item.entryDate
      this.form.startDate = item.startDate
      this.form.career = item.career
      this.form.dataSheet = item.dataSheet
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const doc = {
          title: this.form.title,
          position: this.form.position,
          task: this.form.task,
          entryDate: this.form.entryDate,
          startDate: this.form.startDate,
          career: this.form.career,
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
<!-- model 을(를) 타이틀로 변경(사유: display-quality-firestore를 공용 title로 사용하기 위함) -->
