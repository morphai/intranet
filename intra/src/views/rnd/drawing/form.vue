<template>
  <v-container fluid>
    <v-form>
      <v-card :loading="loading">
        <v-toolbar defect="primary" dark dense>
          <v-toolbar-title>게시판 글 작성</v-toolbar-title>
        <v-spacer/>
        <v-btn icon @click="$router.push('/spc/' + document)"><v-icon>mdi-arrow-left</v-icon></v-btn>
        <v-btn icon @click="save" :disabled="!user"><v-icon>mdi-content-save</v-icon></v-btn>
        </v-toolbar>
        <v-card-text>
          <v-text-field v-model="form.title" outlined label="Model" required></v-text-field>
          <v-text-field v-model="form.partName" outlined label="Part Name" required></v-text-field>
          <v-text-field v-model="form.partNo" outlined label="Part No" required></v-text-field>
          <v-text-field v-model="form.revNo" outlined label="Rev No" required></v-text-field>
          <v-text-field v-model="form.description" outlined label="Description" required></v-text-field>
          <v-text-field v-model="form.designer" outlined label="고객 담당자" required></v-text-field>
          <v-text-field type="date" v-model="form.issueDate" outlined label="등록일자" required></v-text-field>
          <v-text-field v-model="form.dataSheet" outlined label="2D 도면"> required</v-text-field>
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
        partNo: '',
        revNo: '',
        description: '',
        designer: '',
        issueDate: '',
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
      this.ref = this.$firebase.firestore().collection('spc').doc(this.document)
      if (!this.articleId) return
      const doc = await this.ref.collection('articles').doc(this.articleId).get()
      this.exists = doc.exists
      if (!this.exists) return
      const item = doc.data()
      this.form.title = item.title
      this.form.partName = item.partName
      this.form.partNo = item.partNo
      this.form.revNo = item.revNo
      this.form.description = item.description
      this.form.designer = item.designer
      this.form.issueDate = item.issueDate
      this.form.dataSheet = item.dataSheet
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const doc = {
          title: this.form.title,
          partName: this.form.partName,
          partNo: this.form.partNo,
          revNo: this.form.revNo,
          description: this.form.description,
          designer: this.form.designer,
          issueDate: this.form.issueDate,
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
        this.$router.push('/spc/' + this.document)
      }
    }
  }
}
</script>
<!-- model 을(를) 타이틀로 변경(사유: display-spc-firestore를 공용 title로 사용하기 위함) -->
