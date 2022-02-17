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
          <v-select :items="form.title" v-model="form.title" outlined label="자재구분" required></v-select>
          <v-text-field v-model="form.supplier" outlined label="공급처" required></v-text-field>
          <v-text-field v-model="form.model" outlined label="Model(resin명)" required></v-text-field>
          <v-text-field v-model="form.partName" outlined label="Part Name(Grade)" required></v-text-field>
          <v-text-field type="date" v-model="form.inspecDate" outlined label="수입검사일" required></v-text-field>
          <v-text-field v-model="form.lotNo" outlined label="Lot No" required></v-text-field>
          <v-text-field v-model="form.dataSheet1" outlined label="성적서 File"> required</v-text-field>
          <v-text-field v-model="form.dataSheet2" outlined label="측정 Data File"> required</v-text-field>
          <v-select :items="form.result" v-model="form.result" outlined label="판정결과" required></v-select>
          <v-text-field v-model="form.issue" outlined label="판정내용" required></v-text-field>
          <v-text-field v-model="form.actionItem" outlined label="조치항목" required></v-text-field>
          <v-text-field v-model="form.actionProgress" outlined label="조치현황" required></v-text-field>
          <v-text-field v-model="form.actionResult" outlined label="조치결과" required></v-text-field>
          <v-text-field v-model="form.dataSheet3" outlined label="근거자료 File"> required</v-text-field>
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
        title: ['원자재', '부자재', '제품', '완제품'],
        supplier: '',
        model: '',
        partName: '',
        inspecDate: '',
        lotNo: '',
        dataSheet1: '',
        dataSheet2: '',
        result: ['OK', 'NG', '보류'],
        issue: '',
        actionItem: '',
        actionProgress: '',
        actionResult: '',
        dataSheet3: ''
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
      this.form.supplier = item.supplier
      this.form.model = item.model
      this.form.partName = item.partName
      this.form.inspecDate = item.inspecDate
      this.form.lotNo = item.lotNo
      this.form.dataSheet1 = item.dataSheet1
      this.form.dataSheet2 = item.dataSheet2
      this.form.result = item.result
      this.form.issue = item.issue
      this.form.actionItem = item.actionItem
      this.form.actionProgress = item.actionProgress
      this.form.actionResult = item.actionResult
      this.form.dataSheet3 = item.dataSheet3
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const doc = {
          title: this.form.title,
          supplier: this.form.supplier,
          model: this.form.model,
          partName: this.form.partName,
          inspecDate: this.form.inspecDate,
          lotNo: this.form.lotNo,
          dataSheet1: this.form.dataSheet1,
          dataSheet2: this.form.dataSheet2,
          result: this.form.result,
          issue: this.form.issue,
          actionItem: this.form.actionItem,
          actionProgress: this.form.actionProgress,
          actionResult: this.form.actionResult,
          dataSheet3: this.form.dataSheet3,
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
<!-- 첫번째 타이틀 변경(사유: display-quality-firestore를 공용 title로 사용하기 위함) -->
