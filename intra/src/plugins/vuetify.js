import Vue from 'vue'
import Vuetify, { VSnackbar, VBtn, VIcon } from 'vuetify/lib'
import VuetifyToast from 'vuetify-toast-snackbar'
import colors from 'vuetify/lib/util/colors'

import en from 'vuetify/es5/locale/en'
import ko from 'vuetify/es5/locale/ko'

const theme = {
  theme: {
    themes: {
      light: {
        primary: colors.purple,
        secondary: colors.grey.darken1,
        accent: colors.shades.black,
        error: colors.red.accent3
      },
      dark: {
        primary: colors.blue.lighten3
      }
    }
  }
}

Vue.use(Vuetify, {
  components: {
    VSnackbar,
    VBtn,
    VIcon
  }
})
const VuetifyObj = new Vuetify({
  lang: {
    locales: { en, ko },
    current: 'ko'
  },
  theme
})
Vue.use(VuetifyToast, {
  x: 'right', // default
  y: 'bottom', // default
  color: 'info', // default
  icon: 'mdi-information',
  iconColor: '', // default
  classes: [
    'body-2'
  ],
  timeout: 3000, // default
  dismissable: true, // default
  multiLine: false, // default
  vertical: false, // default
  queueable: false, // default
  showClose: false, // default
  closeText: '', // default
  closeIcon: 'close', // default
  closeColor: '', // default
  slot: [], // default
  shorts: {
    custom: {
      color: 'purple'
    }
  },
  property: '$toast', // default
  $vuetify: VuetifyObj.framework
})

export default VuetifyObj
