<template>
  <v-container fluid>
    <v-card>
      <v-toolbar color="primary" dark dense>
        <v-toolbar-title v-text="info.title"></v-toolbar-title>
      <v-spacer/>
      <template v-if="user">
        <v-btn v-if="user.level === 0 || user.level === 1" icon @click="write"><v-icon>mdi-pencil</v-icon></v-btn>
        <v-btn v-if="user.level === 0 || user.level === 1" icon @click="articleWrite"><v-icon>mdi-plus</v-icon></v-btn>
      </template>
      </v-toolbar>
      <v-card-text v-if="info.createdAt">
        <v-alert border="top" type="info" colored-border elevation="2" dismissible>
          <div style="white-space: pre-line">{{info.description}}</div>
          <div class="text-right caption">작성일: {{info.createdAt.toDate().toLocaleDateString()}}</div>
          <div class="text-right caption">수정일: {{info.updatedAt.toDate().toLocaleDateString()}}</div>
        </v-alert>
      </v-card-text>
      <quality-article v-if=" document === 'iso'" :info="info" :document="document"></quality-article>
      <quality-rohs v-if=" document === 'rohs'" :info="info" :document="document"></quality-rohs>
      <quality-ncr v-if=" document === 'ncr'" :info="info" :document="document"></quality-ncr>
      <quality-qmr v-if=" document === 'qmr'" :info="info" :document="document"></quality-qmr>
      <quality-pqcsheet v-if=" document === 'pqcsheet'" :info="info" :document="document"></quality-pqcsheet>
      <quality-4m v-if=" document === '4m'" :info="info" :document="document"></quality-4m>
      <quality-reliability v-if=" document === 'reliability'" :info="info" :document="document"></quality-reliability>
    </v-card>
  </v-container>
</template>
<script>
import QualityArticle from './article/index'
import QualityRohs from './rohs/index'
import QualityNcr from './ncr/index'
import QualityQmr from './qmr/index'
import QualityPqcsheet from './pqcsheet/index'
import Quality4m from './4m/index'
import QualityReliability from './reliability/index'
export default {
  components: { QualityArticle, QualityRohs, QualityNcr, QualityQmr, QualityPqcsheet, Quality4m, QualityReliability },
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
      const ref = this.$firebase.firestore().collection('quality').doc(this.document)
      this.unsubscribe = ref.onSnapshot(doc => {
        if (!doc.exists) return this.write()
        this.info = doc.data()
      })
    },
    async write () {
      this.$router.push(this.$route.path + '/quality-write')
    },
    async articleWrite () {
      this.$router.push({ path: this.$route.path + '/article-write', query: { articleId: '' } })
    }
  }
}
</script>
