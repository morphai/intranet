<template>
  <v-container fluid>
    <v-form>
      <v-card :loading="loading">
        <v-toolbar color="primary" dark dense>
          <v-toolbar-title>공정 치수 입력</v-toolbar-title>
        <v-spacer/>
        <v-btn icon @click="$router.push('/spc/' + document)"><v-icon>mdi-arrow-left</v-icon></v-btn>
        <v-btn icon @click="save" :disabled="!user"><v-icon>mdi-content-save</v-icon></v-btn>
        </v-toolbar>
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-row class="mt-3">
            <v-col>
              <v-text-field type="date" v-model="form.issueDate" :rules="[(v) => !!v || '날짜를 입력하세요']" outlined label="Date" required></v-text-field>
            </v-col>
            <v-col>
              <v-select v-model="form.inspectionCycle" :items="form.inspectionCycleList" :rules="[(v) => !!v || '검사주기를 입력하세요']" outlined label="검사주기" required></v-select>
            </v-col>
            <v-col>
              <v-select v-model="form.model" :items="form.modelList" :rules="[(v) => !!v || '모델명을 입력하세요']" outlined label="Model" required></v-select>
            </v-col>
            <v-col>
              <v-select v-model="form.partName" :items="form.partNameList" outlined label="Part Name" :rules="[(v) => !!v || '부품명을 입력하세요']" required></v-select>
            </v-col>
            <v-col>
              <v-select v-model="form.toolingNo" :items="form.toolingNoList" :rules="[(v) => !!v || '금형차수를 입력하세요']" outlined label="Tooling No" required></v-select>
            </v-col>
            <v-col>
              <v-select v-model="form.cavity" :items="form.cavityList" :rules="[(v) => !!v || '캐비티 번호를 입력하세요']" outlined label="Cavity" required></v-select>
            </v-col>
            <v-col>
              <v-text-field type="number" v-model.number="form.spc1" :rules="[(v) => !!v || '치수를 입력하세요']" outlined label="SPC1" required></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-text-field type="number" v-model.number="form.spc2" outlined label="SPC2" required></v-text-field>
            </v-col>
            <v-col>
              <v-text-field type="number" v-model.number="form.spc3" outlined label="SPC3" required></v-text-field>
            </v-col>
            <v-col>
              <v-text-field type="number" v-model.number="form.spc4" outlined label="SPC4" required></v-text-field>
            </v-col>
            <v-col>
              <v-text-field type="number" v-model.number="form.spc5" outlined label="SPC5/Hole1/전고(N)" required></v-text-field>
            </v-col>
            <v-col>
              <v-text-field type="number" v-model.number="form.spc6" outlined label="SPC6/Hole2/평탄도(N)" required></v-text-field>
            </v-col>
            <v-col>
              <v-select v-model="form.appearance" :items="form.appearanceList" :rules="[(v) => !!v || '외관상태를 입력하세요']" outlined label="외관상태" required></v-select>
            </v-col>
            <v-col>
              <v-select v-model="form.inspector" :items="form.inspectorList" :rules="[(v) => !!v || '검사자를 입력하세요']" outlined label="검사자" required></v-select>
            </v-col>
          </v-row>
        </v-form>
      </v-card>
    </v-form>
  </v-container>
</template>
<script>

export default {
  props: ['document', 'action'],
  data () {
    return {
      valid: true,
      form: {
        issueDate: new Date().toISOString().substr(0, 10),
        inspectionCycle: '',
        inspectionCycleList: ['D1', 'D2', 'D3', 'N1', 'N2', 'N3'],
        model: '',
        modelList: ['AVN', 'AP18C8K', 'AP18E8M', 'AP23A8L', 'BDI FUSE BOX', 'CORTES(SOYUZ)', 'DXD', 'IMS7981', 'P2 CARTRIDGE', 'VOYAGER', 'VOYAGER_M29', '12T50Q', '14Z90Q', '17Z90N'],
        partName: '',
        partNameList: ['BMU COVER', 'BOTTOM CASE', 'CASE', 'COVER', 'FRAME', 'HANDLE', 'HOUSING', 'INNER LOWER', 'LATCH', 'TOP CASE', 'UPPER'],
        toolingNo: '',
        toolingNoList: ['#01', '#02', '#03', '#04', '#05', '#06', '#07', '#08', '#09', '#10', '#11', '#12', '#13', '#14', '#15', '#16', '#17', '#18'],
        cavity: '',
        cavityList: ['C01', 'C02', 'C03', 'C04', 'C05', 'C06', 'C07', 'C08', 'C09', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18', 'C19', 'C20', 'C21', 'C22', 'C23', 'C24', 'C25', 'C26', 'C27', 'C28', 'C29', 'C30', 'C31', 'C32'],
        spc1: null,
        spc2: null,
        spc3: null,
        spc4: null,
        spc5: null,
        spc6: null,
        appearance: '',
        appearanceList: ['OK', 'NG'],
        inspector: '',
        inspectorList: ['곽명순', '이기섭', '정귀홍', '고현호', '박석진']
      },
      exists: false,
      loading: false,
      ref: null
    }
  },
  computed: {
    articleId () {
      return this.$route.query.articleId
    },
    user () {
      return this.$store.state.user
    }
  },
  watch: {
    document () {
      this.fetch()
    }
    // setNull (newVal) {
    //   if (newVal === '') {
    //     this.form.spc2 = null
    //   }
    // }
  },
  created () {
    this.fetch()
  },
  destroyed () {
  },
  methods: {
    async fetch () {
      this.ref = this.$firebase.firestore().collection('spc').doc(this.document)
      if (!this.articleId) return
      const doc = await this.ref.collection('articles').doc(this.articleId).get()
      this.exists = doc.exists
      if (!this.exists) return
      const item = doc.data()
      this.form.issueDate = item.issueDate
      this.form.inspectionCycle = item.inspectionCycle
      this.form.model = item.model
      this.form.partName = item.partName
      this.form.toolingNo = item.toolingNo
      this.form.cavity = item.cavity
      this.form.spc1 = item.spc1
      this.form.spc2 = item.spc2
      this.form.spc3 = item.spc3
      this.form.spc4 = item.spc4
      this.form.spc5 = item.spc5
      this.form.spc6 = item.spc6
      this.form.appearance = item.appearance
      this.form.inspector = item.inspector
    },
    async save () {
      await this.$refs.form.validate()
      if (!this.valid) {
        await this.$refs.form.reset()
      }
      if (this.valid) {
        this.loading = true
        if (this.form.spc2 === '') { this.form.spc2 = null }
        if (this.form.spc3 === '') { this.form.spc3 = null }
        if (this.form.spc4 === '') { this.form.spc4 = null }
        if (this.form.spc5 === '') { this.form.spc5 = null }
        if (this.form.spc6 === '') { this.form.spc6 = null }
        try {
          const createdAt = new Date()
          const id = createdAt.getTime().toString()
          const doc = {
            issueDate: this.form.issueDate,
            inspectionCycle: this.form.inspectionCycle,
            model: this.form.model,
            partName: this.form.partName,
            toolingNo: this.form.toolingNo,
            cavity: this.form.cavity,
            spc1: this.form.spc1,
            spc2: this.form.spc2,
            spc3: this.form.spc3,
            spc4: this.form.spc4,
            spc5: this.form.spc5,
            spc6: this.form.spc6,
            appearance: this.form.appearance,
            inspector: this.form.inspector
          }
          const batch = await this.$firebase.firestore().batch()
          if (!this.articleId) {
            batch.set(this.ref.collection('articles').doc(id), doc)
            batch.update(this.ref, { count: this.$firebase.firestore.FieldValue.increment(1) })
          } else {
            batch.update(this.ref.collection('articles').doc(this.articleId), doc)
          }
          await batch.commit()
        } finally {
          this.loading = false
          this.$router.push('/spc/' + this.document)
        }
      }
    }
  }
}
</script>
<!-- model 을(를) 타이틀로 변경(사유: display-spc-firestore를 공용 title로 사용하기 위함) -->
<!-- null값 처리 참조자료 https://stackoverflow.com/questions/64118345/vuetify-v-text-field-type-number-set-null-instead-of-empty-string -->
