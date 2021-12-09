<template>
  <v-card>
    <v-toolbar color="primary" dark>
      <v-toolbar-title>
        ID: {{item.id}}
      </v-toolbar-title>
      <v-spacer/>
      <span v-if="user">
        <v-btn v-if="user.level === 0 || user.level === 1 || user.level === 5" @click="articleWrite" icon><v-icon>mdi-pencil</v-icon></v-btn>
        <v-btn v-if="user.level === 0 || user.level === 3 || user.level === 5" @click="remove" icon><v-icon>mdi-delete</v-icon></v-btn>
        <v-btn @click="$emit('close')" icon><v-icon>mdi-close</v-icon></v-btn>
      </span>
    </v-toolbar>
    <v-divider></v-divider>
    <v-card-actions>
      <v-card-text>
        {{item.issueDate}} | {{item.inspectionCycle}} | {{item.model}} | {{item.partName}} | {{item.toolingNo}} | {{item.cavity}} | {{item.inspector}}
      </v-card-text>
    </v-card-actions>
  </v-card>
</template>
<script>
export default {
  props: ['document', 'item'],
  data () {
    return {
      ref: this.$firebase.firestore().collection('spc').doc(this.document)
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
      this.$emit('close')
    }
  }
}
</script>
