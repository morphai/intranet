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
      calculate-widths="true"
      must-sort
      item-key="id"
      @click:row="openDialog"
    >
      <template v-slot:item.createdAt="{item}">
        <display-time :time="item.createdAt"></display-time>
      </template>
      <template v-slot:item.dataSheet1="{item}">
        <v-chip icon :href="item.dataSheet1" target="_blank"><v-icon>mdi-file-document-outline</v-icon></v-chip>
      </template>
      <template v-slot:item.dataSheet2="{item}">
        <v-chip icon :href="item.dataSheet2" target="_blank"><v-icon>mdi-file-document-outline</v-icon></v-chip>
      </template>
      <template v-slot:item.dataSheet3="{item}">
        <v-chip icon :href="item.dataSheet3" target="_blank"><v-icon>mdi-file-document-outline</v-icon></v-chip>
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
        { value: 'title', text: '자재구분' },
        { value: 'supplier', text: '공급처' },
        { value: 'model', text: 'Model' },
        { value: 'partName', text: 'Part Name' },
        { value: 'inspecDate', text: '검사일' },
        { value: 'lotNo', text: 'Lot No' },
        { value: 'dataSheet1', text: '성적서' },
        { value: 'dataSheet2', text: '측정 Data' },
        { value: 'user.displayName', text: '검사자' },
        { value: 'result', text: '판정결과' },
        { value: 'issue', text: '판정내용' },
        { value: 'actionItem', text: '조치항목' },
        { value: 'actionProgress', text: '조치현황' },
        { value: 'actionResult', text: '조치결과' },
        { value: 'dataSheet3', text: '근거자료' },
        { value: 'readCount', text: '조회수' },
        { value: 'createdAt', text: '작성일' }
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
