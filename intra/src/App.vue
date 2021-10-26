<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <v-app-bar-nav-icon @click="drawer = !drawer" />
      <v-toolbar-title>Page title</v-toolbar-title>
      <v-spacer />
      <v-btn icon to="/about"><v-icon>mdi-magazine-pistol</v-icon></v-btn>
      <v-btn icon to="/xxx"><v-icon>mdi-magazine-pistol</v-icon></v-btn>
    </v-app-bar>
    <v-navigation-drawer app v-model="drawer">
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>Application</v-list-item-title>
          <v-list-item-subtitle>subtitle</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-navigation-drawer>
    <v-content>
      <router-view />
    </v-content>
    <v-footer app color="primary" dark absolute>
      <v-spacer></v-spacer>
      <div>SHINWHAINTECH</div>
    </v-footer>
  </v-app>
</template>

<script>

export default {
  name: 'App',
  data () {
    return {
      drawer: false
    }
  }
}
</script>
