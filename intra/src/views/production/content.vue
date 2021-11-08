<template>
  <v-container fluid>
    <v-card>
      <v-toolbar color="primary" dark dense>
        <v-toolbar-title v-text="info.title"></v-toolbar-title>
      <v-spacer/>
      <span v-if="user">
        <v-btn v-if="user.level === 0 || user.level === 2" icon @click="write"><v-icon>mdi-pencil</v-icon></v-btn>
        <v-btn v-if="user.level === 0 || user.level === 2" icon @click="articleWrite"><v-icon>mdi-plus</v-icon></v-btn>
      </span>
      </v-toolbar>
      <v-card-text v-if="info.createdAt">
        <v-alert border="top" type="info" colored-border elevation="2" dismissible>
          <div style="white-space: pre-line">{{info.description}}</div>
          <div class="text-right caption">작성일: {{info.createdAt.toDate().toLocaleDateString()}}</div>
          <div class="text-right caption">수정일: {{info.updatedAt.toDate().toLocaleDateString()}}</div>
        </v-alert>
      </v-card-text>
      <template>
      <production-mlist v-if=" document === 'machine-list'" :info="info" :document="document"></production-mlist>
      <production-plan v-if=" document === 'plan'" :info="info" :document="document"></production-plan>
      <production-package v-if=" document === 'package'" :info="info" :document="document"></production-package>
      <production-worksheet v-if=" document === 'worksheet'" :info="info" :document="document"></production-worksheet>
      </template>
    </v-card>
  </v-container>
</template>
<script>
import ProductionMlist from './mlist/index'
import ProductionPlan from './plan/index'
import ProductionPackage from './package/index'
import ProductionWorksheet from './worksheet/index'
export default {
  components: { ProductionMlist, ProductionPlan, ProductionPackage, ProductionWorksheet },
  props: ['document'],
  data () {
    return {
      unsubscribe: null,
      info: {
        category: '',
        title: '',
        description: ''
      },
      loading: false
    }
  },
  watch: {
    document () {
      this.subscribe()
    }
  },
  computed: {
    user () {
      return this.$store.state.user
    }
  },
  created () {
    this.subscribe()
  },
  destroyed () {
    if (this.unsubscribe) this.unsubscribe()
  },
  methods: {
    subscribe () {
      if (this.unsubscribe) this.unsubscribe()
      const ref = this.$firebase.firestore().collection('production').doc(this.document)
      this.unsubscribe = ref.onSnapshot(doc => {
        if (!doc.exists) return this.write()
        this.info = doc.data()
      })
    },
    async write () {
      this.$router.push(this.$route.path + '/production-write')
    },
    async articleWrite () {
      this.$router.push({ path: this.$route.path + '/article-write', query: { articleId: '' } })
      console.log(this.$route.path)
    }
  }
}
</script>
