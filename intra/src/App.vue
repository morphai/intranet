<template>
  <v-app>
    <v-app-bar
      app
      color="grey lighten-2"
    >
      <v-app-bar-nav-icon @click="drawer = !drawer" />
      <site-title :title="site.title"></site-title>
      <v-spacer />
      <site-sign></site-sign>
    </v-app-bar>
    <v-navigation-drawer color="grey lighten-2" app v-model="drawer" width="300">
      <site-menu :items="site.menu"></site-menu>
    </v-navigation-drawer>
    <v-main>
      <router-view />
    </v-main>
    <!-- <site-footer  :footer="site.footer"></site-footer> -->
  </v-app>
</template>

<script>

import siteTitle from '@/views/site/title'
// import siteFooter from '@/views/site/footer'
import siteMenu from '@/views/site/menu'
import siteSign from '@/views/site/sign'
export default {
  components: { siteTitle, siteMenu, siteSign }, // siteFooter 제외
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
