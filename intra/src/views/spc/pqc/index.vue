<template>
  <div>
    <v-card>
      <v-card-title>
        <!-- Data Table -->
        <v-spacer></v-spacer>
        <v-btn  @click="$router.push('/spc/pqc/dashboard')" color="primary" class="ma-2" elevation="2" target="_blank">
          PQC Dashboard
        </v-btn>
      </v-card-title>
      <v-data-table
        :headers="headers"
        :items="items"
        :server-items-length="info.count"
        :options.sync="options"
        :items-per-page="15"
        :footer-props="{
          'items-per-page-options':[15, 50, 100, 500, 1000],
        }"
        must-sort
        item-key="id"
        dense
        @click:row="openDialog"
      >
        <!-- <template v-slot:item.id="{item}">
          <a @click="openDialog(item)"><v-icon color="primary">mdi-file</v-icon></a>
        </template> -->
      </v-data-table>
    </v-card>
    <v-dialog v-if="selectedItem" v-model="dialog" max-width="600">
      <display-spc-firestore :document="document" :item="selectedItem" @close="dialog=false"></display-spc-firestore>
    </v-dialog>
  </div>
</template>
<script>
import { head, last } from 'lodash'
import DisplaySpcFirestore from '@/components/display-spc-firestore'
export default {
  components: { DisplaySpcFirestore },
  props: ['info', 'document'],
  data () {
    return {
      headers: [
        { value: 'issueDate', text: 'Date' },
        { value: 'inspectionCycle', text: 'Time' },
        { value: 'model', text: 'Model' },
        { value: 'partName', text: 'P/Name' },
        { value: 'toolingNo', text: '금형차수' },
        { value: 'cavity', text: 'Cavity' },
        { value: 'spc1', text: 'SPC1' },
        { value: 'spc2', text: 'SPC2' },
        { value: 'spc3', text: 'SPC3' },
        { value: 'spc4', text: 'SPC4' },
        { value: 'spc5', text: 'SPC5' },
        { value: 'spc6', text: 'SPC6' },
        { value: 'appearance', text: '외관' },
        { value: 'inspector', text: '검사자' }
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
