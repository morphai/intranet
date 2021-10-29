<template>
  <v-tooltip bottom>
    <template v-slot:activator="{on}">
      <v-chip v-on="on" color="primary">
        <v-avatar left>
          <v-img :src="user.photoURL"></v-img>
        </v-avatar>
        <span v-if="user.email == 'justice0408@gmail.com'">대표이사 / 김기현</span>
        <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">품질팀 / 김기현</span>
      </v-chip>
    </template>
    <span v-if="user.email == 'justice0408@gmail.com'">khkim@shinwhaintec.co.kr | 010-7105-4882</span>
      <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">품질팀 | 김기현</span>
  </v-tooltip>
</template>
<script>
export default {
  props: ['user']
}
</script>

<!-- <template>
  <v-tooltip bottom>
    <template v-slot:activator="{on}">
      <v-chip v-on="on" color="primary">
        <v-avatar left>
          <v-img :src="user.photoURL"></v-img>
        </v-avatar>
        {{user.displayName}}
      </v-chip>
    </template>
    <span v-if="user.email == 'justice0408@gmail.com'">대표이사 / 김기현</span>
    <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">품질팀 / 김기현</span>
  </v-tooltip>
</template>
<script>
export default {
  props: ['user']
}
</script> -->
