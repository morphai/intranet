<template>
  <v-container fluid>
    <v-form>
      <v-card :loading="loading">
        <v-toolbar color="primary" dark dense>
          <v-toolbar-title>게시판 글 작성</v-toolbar-title>
        <v-spacer/>
        <v-btn icon @click="$router.push('/production/' + document)"><v-icon>mdi-arrow-left</v-icon></v-btn>
        <v-btn icon @click="save" :disabled="!user"><v-icon>mdi-content-save</v-icon></v-btn>
        </v-toolbar>
        <v-card-text>
          <v-text-field v-model="form.facilityName" outlined label="설비명" required></v-text-field>
          <v-text-field v-model="form.modelName" outlined label="모델명" required></v-text-field>
          <v-text-field v-model="form.spec" outlined label="사양" required></v-text-field>
          <v-text-field v-model="form.serialNo" outlined label="시리얼넘버" required></v-text-field>
          <v-text-field v-model="form.maker" outlined label="제조사" required></v-text-field>
          <v-text-field type="date" v-model="form.purchaseDate" outlined label="구매일자" required></v-text-field>
          <v-text-field v-model="form.remark" outlined label="비고"></v-text-field>
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
        facilityName: '',
        modelName: '',
        spec: '',
        serialNo: '',
        maker: '',
        purchaseDate: '',
        remark: '',
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
      this.ref = this.$firebase.firestore().collection('production').doc(this.document)
      if (!this.articleId) return
      const doc = await this.ref.collection('articles').doc(this.articleId).get()
      this.exists = doc.exists
      if (!this.exists) return
      const item = doc.data()
      this.form.facilityName = item.facilityName
      this.form.modelName = item.modelName
      this.form.spec = item.spec
      this.form.serialNo = item.serialNo
      this.form.maker = item.maker
      this.form.purchaseDate = item.purchaseDate
      this.form.remark = item.remark
      const { data } = await axios.get(item.url)
      this.form.content = data
    },
    async save () {
      this.loading = true
      try {
        const createdAt = new Date()
        const id = createdAt.getTime().toString()
        const md = this.$refs.editor.invoke('getMarkdown')
        const sn = await this.$firebase.storage().ref().child('production').child(this.document).child(!this.articleId ? id + '.md' : this.articleId + '.md').putString(md)
        // storage overwrite 불가 문제로 삼항 연산자 적용 (추후 동작 확인필요)
        const url = await sn.ref.getDownloadURL()
        const doc = {
          facilityName: this.form.facilityName,
          modelName: this.form.modelName,
          spec: this.form.spec,
          serialNo: this.form.serialNo,
          maker: this.form.maker,
          purchaseDate: this.form.purchaseDate,
          remark: this.form.remark,
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
        this.loading = false
        this.$router.push('/production/' + this.document)
      }
    }
  }
}
</script>
