<template>
  <v-card>
    <v-toolbar color="primary" dark>
      <v-toolbar-title>
        {{item.facilityName}}
      </v-toolbar-title>
      <v-spacer/>
      <span v-if="user">
        <v-btn v-if="user.level === 0 || user.level === 2" @click="articleWrite" icon><v-icon>mdi-pencil</v-icon></v-btn>
        <v-btn v-if="user.level === 0 || user.level === 2" @click="remove" icon><v-icon>mdi-delete</v-icon></v-btn>
        <v-btn @click="$emit('close')" icon><v-icon>mdi-close</v-icon></v-btn>
      </span>
    </v-toolbar>
    <v-card-text class="mt-5">
      <viewer v-if="content" :initialValue="content"></viewer>
      <v-container v-else>
        <v-row justify="center" align="center">
          <v-progress-circular indeterminate></v-progress-circular>
        </v-row>
      </v-container>
    </v-card-text>
    <v-divider></v-divider>
    <v-card-actions>
      <v-spacer/>
      <span class="caption">
        작성일: <display-time :time="item.createdAt"></display-time>
      </span>
    </v-card-actions>
    <v-card-actions>
      <v-spacer/>
      <span class="caption">
        수정일: <display-time :time="item.updatedAt"></display-time>
      </span>
    </v-card-actions>
  </v-card>
</template>
<script>
import axios from 'axios'
import DisplayTime from '@/components/display-time'
export default {
  components: { DisplayTime },
  props: ['document', 'item'],
  data () {
    return {
      content: '',
      ref: this.$firebase.firestore().collection('production').doc(this.document)
    }
  },
  computed: {
    user () {
      return this.$store.state.user
    }
  },
  mounted () {
    this.fetch()
  },
  methods: {
    async fetch () {
      const r = await axios.get(this.item.url)
      this.content = r.data
      await this.ref.collection('articles').doc(this.item.id)
        .update({
          readCount: this.$firebase.firestore.FieldValue.increment(1)
        })
    },
    async articleWrite () {
      this.$router.push({ path: this.$route.path + '/article-write', query: { articleId: this.item.id } })
    },
    async remove () {
      const batch = this.$firebase.firestore().batch()
      batch.update(this.ref, { count: this.$firebase.firestore.FieldValue.increment(-1) })
      batch.delete(this.ref.collection('articles').doc(this.item.id))
      await batch.commit()
      await this.$firebase.storage().ref().child('production').child(this.document).child(this.item.id + '.md').delete()
      this.$emit('close')
    }
  }
}
</script>
<!-- display-production 다이얼로그 생성시 storage를 불러오지 못하고 e.split 에러가 나오는 경우 서버의 data를 지우고 다시 시작(문제점은 찾아야 함) -->
