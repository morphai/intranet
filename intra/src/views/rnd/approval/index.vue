<template>
  <div>
    <v-data-table
      :headers="headers"
      :items="items"
      :server-items-length="info.count"
      :options.sync="options"
      :items-per-page="5"
      :footer-props="{
        'items-per-page-options':[5, 10, 20, 30, 50],
      }"
      must-sort
      item-key="id"
    >
      <template v-slot:item.title="{item}">
        <a @click="openDialog(item)">{{item.title}}</a>
      </template>
      <template v-slot:item.createdAt="{item}">
        <display-time :time="item.createdAt"></display-time>
      </template>
      <template v-slot:item.dataSheet="{item}">
        <v-chip color="green" text-color="white" icon :href="item.dataSheet" target="_blank"><v-icon left>mdi-file</v-icon>DataSheet</v-chip>
      </template>
      <template v-slot:item.user.displayName="{item}">
        <display-user :user="item.user"></display-user>
      </template>

    </v-data-table>
    <v-dialog v-if="selectedItem" v-model="dialog" max-width="1000">
      <display-rnd-firestore :document="document" :item="selectedItem" @close="dialog=false"></display-rnd-firestore>
    </v-dialog>
  </div>
</template>
<script>
import { head, last } from 'lodash'
import DisplayTime from '@/components/display-time'
import DisplayUser from '@/components/display-user'
import DisplayRndFirestore from '@/components/display-rnd-firestore'
export default {
  components: { DisplayTime, DisplayUser, DisplayRndFirestore },
  props: ['info', 'document'],
  data () {
    return {
      headers: [
        { value: 'title', text: 'Model' },
        { value: 'partName', text: 'Part Name' },
        { value: 'partNo', text: 'Part No' },
        { value: 'toolNo', text: 'Tooling No' },
        { value: 'customer', text: '고객 담당자' },
        { value: 'issueDate', text: '등록일자' },
        { value: 'dataSheet', text: '승인서류' },
        { value: 'user.displayName', text: '작성자' },
        { value: 'readCount', text: '조회수' },
        { value: 'createdAt', text: '작성일' }
        // { value: 'commentCount', text: '댓글' }
      ],
      items: [],
      unsubscribe: null,
      options: {
        sortBy: ['createdAt'],
        sortDesc: [true]
      },
      docs: [],
      dialog: false,
      selectedItem: null
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
      const ref = this.$firebase.firestore().collection('rnd').doc(this.document).collection('articles').orderBy(order, sort)
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
