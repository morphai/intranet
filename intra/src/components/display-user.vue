<template>
  <v-tooltip bottom>
    <template v-slot:activator="{on}">
      <v-chip v-on="on">
        <v-avatar left>
          <v-img :src="user.photoURL"></v-img>
        </v-avatar>
        <span v-if="user.email == 'justice0408@gmail.com'">대표이사 / 김기현</span>
        <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">대표이사 / daniel</span>
        <span v-else-if="user.email == 'kslee2471@gmail.com'">품질팀 / 이기섭</span>
        <span v-else-if="user.email == 'jgh208011@gmail.com'">생산팀 / 정귀홍</span>
        <span v-else-if="user.email == 'k01084119633@gmail.com'">품질팀 / 곽명순</span>
        <span v-else-if="user.email == 'kohh8611@gmail.com'">영업팀 / 고현호</span>
        <span v-else-if="user.email == 'choihyuk970318@gmail.com'">개발팀 / 최혁</span>
        <span v-else-if="user.email == 'sohis41@gmail.com'">자재구매팀 / 전승민</span>
        <!--
          <span v-else-if="user.email == 'yain369@gmail.com'">개발팀 / 박석진</span>
          <span v-else-if="user.email == 'bobby48645@gmail.com'">품질팀 / 권혁일</span>
          <span v-else-if="user.email == 'neokyj72@gmail.com'">품질팀 / 김용진</span>
          <span v-else-if="user.email == 'alswjd37018407@gmail.com'">품질팀 / 조민정</span>
          <span v-else-if="user.email == 'soulsorter@gmail.com'">품질/영업팀 / 한동춘</span>
        -->
      </v-chip>
    </template>
    <span v-if="user.email == 'justice0408@gmail.com'">khkim@shinwhaintec.co.kr | 010-7105-4882</span>
    <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">khkim@shinwhaintec.co.kr | 010-7105-4882</span>
    <span v-else-if="user.email == 'kslee2471@gmail.com'">kslee@shinwhaintec.co.kr | 010-4022-2471</span>
    <span v-else-if="user.email == 'jgh208011@gmail.com'">ghjung@shinwhaintec.co.kr | 010-3821-3299</span>
    <span v-else-if="user.email == 'k01084119633@gmail.com'">msgwak@shinwhaintec.co.kr | 010-8411-9633</span>
    <span v-else-if="user.email == 'kohh8611@gmail.com'">hhko@shinwhaintec.co.kr | 010-4641-8611</span>
    <span v-else-if="user.email == 'choihyuk970318@gmail.com'">hchoi@shinwhaintec.co.kr | 010-5637-9718</span>
    <span v-else-if="user.email == 'sohis41@gmail.com'">smjeon@shinwhaintec.co.kr | 010-4939-0341</span>
    <!--
      <span v-else-if="user.email == 'yain369@gmail.com'">sjpark@shinwhaintec.co.kr | 010-2292-3888</span>
      <span v-else-if="user.email == 'bobby48645@gmail.com'">hikwon@shinwhaintec.co.kr | 010-8205-0712</span>
      <span v-else-if="user.email == 'neokyj72@gmail.com'">yjkim@shinwhaintec.co.kr | 010-2752-0378</span>
      <span v-else-if="user.email == 'alswjd37018407@gmail.com'">mjcho@shinwhaintec.co.kr | 010-3701-8407</span>
      <span v-else-if="user.email == 'soulsorter@gmail.com'">dchan@shinwhaintec.co.kr | 010-9998-9834</span>
    -->
  </v-tooltip>
</template>
<script>
export default {
  props: ['user']
}
</script>

<!--
  신규인원추가시 순서
  1. 위에 두 내용 추가
  approvedLevel
  admin= 0,
  quality = 1,
  production = 2,
  purchase = 2,
  rnd = 3,
  sales = 4,
  pqc = 5
-->
