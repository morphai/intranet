<template>
  <v-footer v-if="user" app color="grey lighten-2" absolute :footer="footer">
    <v-spacer></v-spacer>
    <div>&copy; {{ new Date().getFullYear() + ' ' + footer }}</div>
    <v-btn v-if="user.level < 1" icon @click="openDialog"><v-icon>mdi-pencil</v-icon></v-btn>
    <v-dialog v-model="dialog" max-width="400">
      <v-card>
        <v-card-title>
          제목 수정
          <v-spacer/>
          <v-btn icon @click="save"><v-icon>mdi-content-save</v-icon></v-btn>
          <v-btn icon @click="dialog=false"><v-icon>mdi-close</v-icon></v-btn>
        </v-card-title>
        <v-card-text>
          <v-text-field v-model="text" outlined label="제목" @keypress.enter="save" hide-details />
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-footer>
</template>
<script>
export default {
  props: ['footer'],
  data () {
    return {
      dialog: false,
      text: this.footer
    }
  },
  computed: {
    user () {
      return this.$store.state.user
    }
  },
  methods: {
    openDialog () {
      this.dialog = true
    },
    async save () {
      try {
        await this.$firebase.database().ref().child('site').update({ footer: this.text })
      } finally {
        this.dialog = false
      }
    }
  }
}
</script>
