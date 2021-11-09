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
          <v-text-field v-model="form.title" outlined label="Model" required></v-text-field>
          <v-text-field v-model="form.partName" outlined label="Part Name" required></v-text-field>
          <v-text-field v-model="form.reason" outlined label="변경사유" required></v-text-field>
          <v-text-field type="date" v-model="form.regDate" outlined label="등록일자" required></v-text-field>
          <v-text-field type="date" v-model="form.approvalDate" outlined label="승인일자" required></v-text-field>
          <v-text-field v-model="form.dataSheet1" outlined label="4M File"> required</v-text-field>
          <v-text-field v-model="form.dataSheet2" outlined label="유효성 검증 File"> required</v-text-field>
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
        partName: '',
        reason: '',
        regDate: '',
        approvalDate: '',
        dataSheet1: '',
        dataSheet2: ''
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
      this.form.partName = item.partName
      this.form.reason = item.reason
      this.form.regDate = item.regDate
      this.form.approvalDate = item.approvalDate
      this.form.dataSheet1 = item.dataSheet1
      this.form.dataSheet2 = item.dataSheet2
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const doc = {
          title: this.form.title,
          partName: this.form.partName,
          reason: this.form.reason,
          regDate: this.form.regDate,
          approvalDate: this.form.approvalDate,
          dataSheet1: this.form.dataSheet1,
          dataSheet2: this.form.dataSheet2,
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
<!-- model 타이틀로 변경(사유: display-quality-firestore를 공용 title로 사용하기 위함) -->
