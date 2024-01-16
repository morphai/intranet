<template>
  <v-app>
    <v-app-bar
      app
      dense
    >
      <v-app-bar-nav-icon @click="drawer = !drawer" />
      <v-btn class="ma-2" elevation="2" :href="'https://login.ecount.com/Login/KR/'" target="_blank">
        ERP
      </v-btn>
      <v-spacer />
      <!-- <site-title :title="site.title"></site-title> -->
      <v-spacer />
      <template v-if="user">
        <v-icon left>mdi-card-account-details</v-icon>{{user.displayName}}
        <v-icon left class="ml-5">mdi-email</v-icon>
        <span v-if="user.email == 'justice0408@gmail.com'">khkim@shinwhaintec.co.kr</span> <!--관리자-->
        <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">khkim@shinwhaintec.co.kr</span> <!--developer-->
        <span v-else-if="user.email == 'kslee2471@gmail.com'">kslee@shinwhaintec.co.kr</span> <!--품질/이기섭-->
        <span v-else-if="user.email == 'jgh208011@gmail.com'">ghjung@shinwhaintec.co.kr</span> <!--생산/정귀홍-->
        <span v-else-if="user.email == 'k01084119633@gmail.com'">k01084119633@gmail.com</span> <!--품질/곽명순-->
        <span v-else-if="user.email == 'kohh8611@gmail.com'">hhko@shinwhaintec.co.kr</span> <!--영업/고현호-->
        <span v-else-if="user.email == 'jaewan77777@gmail.com'">jwpark@shinwhaintec.co.kr</span> <!--구매/박재완-->
        <!--
          <span v-else-if="user.email == 'yain369@gmail.com'">sjpark@shinwhaintec.co.kr</span>
        -->
      </template>
      <v-switch
        color="red"
        v-model="$vuetify.theme.dark"
        inset
        class="ml-7 mr-4 mt-5"
      ></v-switch>
      <!-- title로 이전필요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
      <site-sign></site-sign>
    </v-app-bar>
    <v-navigation-drawer app dark v-model="drawer" width="300">
      <site-menu :items="site.menu"></site-menu>
    </v-navigation-drawer>
    <v-main>
      <router-view />
    </v-main>
    <!-- <site-footer  :footer="site.footer"></site-footer> -->
  </v-app>
</template>

<script>

// import siteTitle from '@/views/site/title'
// import siteFooter from '@/views/site/footer'
import siteMenu from '@/views/site/menu'
import siteSign from '@/views/site/sign'
export default {
  components: { siteMenu, siteSign }, // siteTitle, siteFooter 제외
  name: 'App',
  data () {
    return {
      drawer: false,
      site: {
        menu: [
          {
            title: 'home',
            icon: 'mdi-home',
            subItems: [
              {
                title: 'Dashboard',
                to: '/'
              },
              {
                title: 'About',
                to: '/about'
              }
            ]
          },
          {
            title: 'about',
            icon: 'mdi-information',
            active: true,
            subItems: [
              {
                title: 'xxx',
                to: '/xxx'
              }
            ]
          }
        ],
        title: 'Intranet',
        footer: 'Shinwhaintech Co.,Ltd'
      }
    }
  },
  created () {
    this.subscribe()
  },
  computed: {
    user () {
      return this.$store.state.user
    }
  },
  methods: {
    subscribe () {
      this.$firebase.database().ref().child('site').on('value', (sn) => {
        const v = sn.val()
        if (!v) {
          this.$firebase.database().ref().child('site').set(this.site)
          return
        }
        this.site = v
      }, (e) => {
        console.log(e.message)
      })
    }
  }
}
</script>
