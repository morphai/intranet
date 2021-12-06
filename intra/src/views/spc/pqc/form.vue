<template>
  <v-container fluid>
    <v-form>
      <v-card :loading="loading">
        <v-toolbar color="primary" dark dense>
          <v-toolbar-title>게시판 글 작성</v-toolbar-title>
        <v-spacer/>
        <v-btn icon @click="$router.push('/spc/' + document)"><v-icon>mdi-arrow-left</v-icon></v-btn>
        <v-btn icon @click="save" :disabled="!user"><v-icon>mdi-content-save</v-icon></v-btn>
        </v-toolbar>
        <v-card-text>
          <v-text-field type="date" v-model="form.issueDate" outlined label="Date" required></v-text-field>
          <v-select v-model="form.cycle" :items="form.cycleList" outlined label="검사주기" required></v-select>
          <v-select v-model="form.model" :items="form.modelList" outlined label="Model" required></v-select>
          <v-select v-model="form.partName" :items="form.partNameList" outlined label="Part Name" required></v-select>
          <v-select v-model="form.ToolingNo" :items="form.ToolingNoList" outlined label="Tooling No" required></v-select>
          <v-select v-model="form.cavity" :items="form.cavityList" outlined label="Cavity" required></v-select>
          <v-text-field v-model.number="form.spc1" outlined label="spc1" required></v-text-field>
          <v-text-field v-model.number="form.spc2" outlined label="spc2" required></v-text-field>
          <v-text-field v-model.number="form.spc3" outlined label="spc3" required></v-text-field>
          <v-text-field v-model.number="form.spc4" outlined label="spc4" required></v-text-field>
          <v-text-field v-model.number="form.spc5" outlined label="spc5/hole1" required></v-text-field>
          <v-text-field v-model.number="form.spc6" outlined label="spc6/hole2" required></v-text-field>
          <v-select v-model="form.appearance" :items="form.appearanceList" outlined label="외관상태" required></v-select>
          <v-select v-model="form.articleWriter" :items="form.articleWriterList" outlined label="검사자" required></v-select>
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
        issueDate: '',
        cycle: '',
        cycleList: ['D1', 'D2', 'D3', 'N1', 'N2', 'N3'],
        model: '',
        modelList: ['AP18C8K', 'CORTES(SOYUZ)', 'AVN', 'VOYAGER', 'DXD'],
        partName: '',
        partNameList: ['FRAME', 'CASE', 'TOP CASE', 'BOTTOM CASE', 'LATCH', 'HANDLE'],
        ToolingNo: '',
        ToolingNoList: ['#01', '#02', '#03', '#04', '#05', '#06', '#07', '#08', '#09', '#10', '#11', '#12'],
        cavity: '',
        cavityList: ['C01', 'C02', 'C03', 'C04', 'C05', 'C06', 'C07', 'C08', 'C09', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16'],
        spc1: '',
        spc2: '',
        spc3: '',
        spc4: '',
        spc5: '',
        spc6: '',
        appearance: '',
        appearanceList: ['OK', 'NG'],
        articleWriter: '',
        articleWriterList: ['정귀홍', '한동춘', '김용진', '조민정', '박석진', '곽명순', '이엔']
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
      this.form.issueDate = item.issueDate
      this.form.cycle = item.cycle
      this.form.model = item.model
      this.form.partName = item.partName
      this.form.ToolingNo = item.ToolingNo
      this.form.cavity = item.cavity
      this.form.spc1 = item.spc1
      this.form.spc2 = item.spc2
      this.form.spc3 = item.spc3
      this.form.spc4 = item.spc4
      this.form.spc5 = item.spc5
      this.form.spc6 = item.spc6
      this.form.appearance = item.appearance
      this.form.articleWriter = item.articleWriter
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const doc = {
          issueDate: this.form.issueDate,
          cycle: this.form.cycle,
          model: this.form.model,
          partName: this.form.partName,
          ToolingNo: this.form.ToolingNo,
          cavity: this.form.cavity,
          spc1: this.form.spc1,
          spc2: this.form.spc2,
          spc3: this.form.spc3,
          spc4: this.form.spc4,
          spc5: this.form.spc5,
          spc6: this.form.spc6,
          appearance: this.form.appearance,
          articleWriter: this.form.articleWriter,
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
        console.log(this.form.cycle)
      }
    }
  }
}
</script>
<!-- model 을(를) 타이틀로 변경(사유: display-spc-firestore를 공용 title로 사용하기 위함) -->
