<template>
  <v-tooltip bottom>
    <template v-slot:activator="{on}">
      <v-chip v-on="on" color="primary">
        <v-avatar left>
          <v-img :src="user.photoURL"></v-img>
        </v-avatar>
        <span v-if="user.email == 'justice0408@gmail.com'">대표이사 / 김기현</span>
        <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">대표이사 / daniel</span>
        <span v-else-if="user.email == 'neokyj72@gmail.com'">품질팀 / 김용진</span>
        <span v-else-if="user.email == 'alswjd37018407@gmail.com'">품질팀 / 조민정</span>
        <span v-else-if="user.email == 'soulsorter@gmail.com'">영업팀 / 한동춘</span>
        <span v-else-if="user.email == 'jgh208011@gmail.com'">생산팀 / 정귀홍</span>
        <span v-else-if="user.email == 'yain369@gmail.com'">개발팀 / 박석진</span>
      </v-chip>
    </template>
    <span v-if="user.email == 'justice0408@gmail.com'">khkim@shinwhaintec.co.kr | 010-7105-4882</span>
    <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">khkim@shinwhaintec.co.kr | 010-7105-4882</span>
    <span v-else-if="user.email == 'neokyj72@gmail.com.com'">yjkim@shinwhaintec.co.kr | 010-2752-0378</span>
    <span v-else-if="user.email == 'alswjd37018407@gmail.com'">xxx@shinwhaintec.co.kr | 010-3701-8407</span>
    <span v-else-if="user.email == 'soulsorter@gmail.com'">dchan@shinwhaintec.co.kr | 010-9998-9834</span>
    <span v-else-if="user.email == 'jgh208011@gmail.com'">xxx@shinwhaintec.co.kr | 010-3821-3299</span>
    <span v-else-if="user.email == 'yain369@gmail.com'">sjpark@shinwhaintec.co.kr | 010-2292-3888</span>
  </v-tooltip>
</template>
<script>
export default {
  props: ['user']
}
</script>

<!--
  approvedLevel
  admin= 0,
  quality = 1,
  production = 2,
  rnd = 3,
  sales = 4
-->
