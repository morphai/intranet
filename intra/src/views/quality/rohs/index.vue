<template>
  <div>
    <v-data-table
      :headers="headers"
      :items="items"
      :server-items-length="info.count"
      :options.sync="options"
      :items-per-page="10"
      :footer-props="{
        'items-per-page-options':[10, 20, 30, 50, 100],
      }"
      must-sort
      item-key="id"
      @click:row="openDialog"
    >
      <template v-slot:item.createdAt="{item}">
        <display-time :time="item.createdAt"></display-time>
      </template>
      <template v-slot:item.dataSheet="{item}">
        <v-chip :disabled="item.expirationDate < toDay" icon :href="item.dataSheet" target="_blank">
          <v-icon>mdi-file-document-outline</v-icon>
        </v-chip>
      </template>
      <template v-slot:item.user.displayName="{item}">
        <display-user :user="item.user"></display-user>
      </template>

    </v-data-table>
    <v-dialog v-if="selectedItem" v-model="dialog" max-width="600">
      <display-quality-firestore :document="document" :item="selectedItem" @close="dialog=false"></display-quality-firestore>
    </v-dialog>
  </div>
</template>
<script>
import { head, last } from 'lodash'
import DisplayTime from '@/components/display-time'
import DisplayUser from '@/components/display-user'
import DisplayQualityFirestore from '@/components/display-quality-firestore'
export default {
  components: { DisplayTime, DisplayUser, DisplayQualityFirestore },
  props: ['info', 'document'],
  data () {
    return {
      headers: [
        { value: 'title', text: 'Maker' },
        { value: 'grade', text: 'Grade' },
        { value: 'color', text: 'Color' },
        { value: 'category', text: 'category' },
        { value: 'issueDate', text: '발행일자' },
        { value: 'expirationDate', text: '유효일자' },
        { value: 'certificationAuth', text: '발행기관' },
        { value: 'dataSheet', text: 'Data Sheet' },
        { value: 'user.displayName', text: '작성자' },
        { value: 'readCount', text: '조회수' },
        { value: 'createdAt', text: '작성일' }
      ],
      items: [],
      unsubscribe: null,
      options: {
        sortBy: ['issueDate'],
        sortDesc: [true]
      },
      docs: [],
      dialog: false,
      selectedItem: null,
      // toDay: new Date().toLocaleDateString()
      toDay: new Date().toISOString().substring(0, 10)
    }
  },
  watch: {
    document () {
      this.subscribe(0)
    },
    options: {
      handler (n, o) {
        if (!o.page) {
          this.subscribe(0)
          return
        }
        if (head(o.sortBy) !== head(n.sortBy) || head(o.sortDesc) !== head(n.sortDesc)) {
          n.page = 1
          this.subscribe(0)
          return
        }
        const arrow = n.page - o.page
        this.subscribe(arrow)
      },
      deep: true
    },
    dialog (n) {
      if (!n) this.selectedItem = null
    }
  },
  created () {
    // this.subscribe(0)
    console.log(this.document)
  },
  destroyed () {
    if (this.unsubscribe) this.unsubscribe()
  },
  methods: {
    subscribe (arrow) {
      if (this.unsubscribe) this.unsubscribe()
      const order = this.options.sortBy[0]
      const sort = this.options.sortDesc[0] ? 'desc' : 'asc'
      const limit = this.options.itemsPerPage
      const ref = this.$firebase.firestore().collection('quality').doc(this.document).collection('articles').orderBy(order, sort)
      let query
      switch (arrow) {
        case -1: query = ref.endBefore(head(this.docs)).limitToLast(limit)
          break
        case 1: query = ref.startAfter(last(this.docs)).limit(limit)
          break
        default: query = ref.limit(limit)
          break
      }
      this.unsubscribe = query.onSnapshot(sn => {
        if (sn.empty) {
          this.items = []
          return
        }
        this.docs = sn.docs
        this.items = sn.docs.map(doc => {
          const item = doc.data()
          item.id = doc.id
          item.createdAt = item.createdAt.toDate()
          item.updatedAt = item.updatedAt.toDate()
          return item
        })
      })
    },
    openDialog (item) {
      this.selectedItem = item
      this.dialog = true
      console.log(this.item)
    }
  }
}
</script>
