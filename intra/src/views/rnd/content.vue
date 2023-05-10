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
      <rnd-drawing v-if=" document === 'drawing'" :info="info" :document="document"></rnd-drawing>
      <rnd-approval v-if=" document === 'approval'" :info="info" :document="document"></rnd-approval>
      <rnd-dfmea v-if=" document === 'dfmea'" :info="info" :document="document"></rnd-dfmea>
      <rnd-meeting v-if=" document === 'meeting'" :info="info" :document="document"></rnd-meeting>
    </v-card>
  </v-container>
</template>
<script>
import RndDrawing from './drawing/index'
import RndApproval from './approval/index'
import RndDfmea from './dfmea/index'
import RndMeeting from './meeting/index'
export default {
  components: { RndDrawing, RndApproval, RndDfmea, RndMeeting },
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
      const ref = this.$firebase.firestore().collection('rnd').doc(this.document)
      this.unsubscribe = ref.onSnapshot(doc => {
        if (!doc.exists) return this.write()
        this.info = doc.data()
      })
    },
    async write () {
      this.$router.push(this.$route.path + '/rnd-write')
    },
    async articleWrite () {
      this.$router.push({ path: this.$route.path + '/article-write', query: { articleId: '' } })
    }
  }
}
</script>
