<template>
  <v-container fluid>
    <v-card>
      <v-toolbar color="primary" dark dense>
        <v-toolbar-title v-text="info.title"></v-toolbar-title>
      <v-spacer/>
      <template v-if="user">
        <v-btn v-if="user.level === 0 || user.level === 3 || user.level == 1" icon @click="write"><v-icon>mdi-pencil</v-icon></v-btn>
        <v-btn v-if="user.level === 0 || user.level === 3 || user.level == 1" icon @click="articleWrite"><v-icon>mdi-plus</v-icon></v-btn>
      </template>
      </v-toolbar>
      <v-card-text v-if="info.createdAt">
        <v-alert border="top" type="info" colored-border elevation="2" dismissible>
          <div style="white-space: pre-line">{{info.description}}</div>
          <!-- <div class="text-right caption">작성일: {{info.createdAt.toDate().toLocaleDateString()}}</div>
          <div class="text-right caption">수정일: {{info.updatedAt.toDate().toLocaleDateString()}}</div> -->
        </v-alert>
      </v-card-text>
      <mold-repair v-if=" document === 'repair'" :info="info" :document="document"></mold-repair>
      <mold-tooling v-if=" document === 'tooling'" :info="info" :document="document"></mold-tooling>
      <mold-shot v-if=" document === 'shot'" :info="info" :document="document"></mold-shot>
    </v-card>
  </v-container>
</template>
<script>
import MoldRepair from './repair/index'
import MoldTooling from './tooling/index'
import MoldShot from './shot/index'
export default {
  components: { MoldRepair, MoldTooling, MoldShot },
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
      const ref = this.$firebase.firestore().collection('mold').doc(this.document)
      this.unsubscribe = ref.onSnapshot(doc => {
        if (!doc.exists) return this.write()
        this.info = doc.data()
      })
    },
    async write () {
      this.$router.push(this.$route.path + '/mold-write')
    },
    async articleWrite () {
      this.$router.push({ path: this.$route.path + '/article-write', query: { articleId: '' } })
    }
  }
}
</script>
