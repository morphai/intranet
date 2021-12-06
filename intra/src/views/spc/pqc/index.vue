<template>
  <div>
    <v-data-table
      :headers="headers"
      :items="items"
      :server-items-length="info.count"
      :options.sync="options"
      :items-per-page="5"
      :footer-props="{
        'items-per-page-options':[10, 20, 30, 50],
      }"
      must-sort
      item-key="id"
      dense
    >
      <template v-slot:item.id="{item}">
        <a @click="openDialog(item)">{{item.id}}</a>
      </template>
      <template v-slot:item.createdAt="{item}">
        <display-time :time="item.createdAt"></display-time>
      </template>
      <!-- <template v-slot:item.user.displayName="{item}">
        <display-user :user="item.user"></display-user>
      </template> -->

    </v-data-table>
    <v-dialog v-if="selectedItem" v-model="dialog" max-width="1000">
      <display-spc-firestore :document="document" :item="selectedItem" @close="dialog=false"></display-spc-firestore>
    </v-dialog>
  </div>
</template>
<script>
import { head, last } from 'lodash'
import DisplayTime from '@/components/display-time'
// import DisplayUser from '@/components/display-user'
import DisplaySpcFirestore from '@/components/display-spc-firestore'
export default {
  components: { DisplayTime, DisplaySpcFirestore },
  props: ['info', 'document'],
  data () {
    return {
      headers: [
        { value: 'id', text: 'ID', sortable: false },
        { value: 'issueDate', text: 'Date' },
        { value: 'cycle', text: 'Cycle' },
        { value: 'model', text: 'Model' },
        { value: 'partName', text: 'Part_Name' },
        { value: 'ToolingNo', text: 'Tooling_No' },
        { value: 'cavity', text: 'Cavity' },
        { value: 'spc1', text: 'SPC1' },
        { value: 'spc2', text: 'SPC2' },
        { value: 'spc3', text: 'SPC3' },
        { value: 'spc4', text: 'SPC4' },
        { value: 'spc5', text: 'SPC5' },
        { value: 'spc6', text: 'SPC6' },
        { value: 'appearance', text: '와관' },
        { value: 'articleWriter', text: '검사자' }
        // { value: 'createdAt', text: '작성일' }
        // { value: 'commentCount', text: '댓글' }
      ],
      items: [],
      unsubscribe: null,
      options: {
        sortBy: ['issueDate'],
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
      const ref = this.$firebase.firestore().collection('spc').doc(this.document).collection('articles').orderBy(order, sort)
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
    }
  }
}
</script>
