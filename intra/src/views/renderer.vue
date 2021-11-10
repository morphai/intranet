<template>
  <quality-content v-if="collection === 'quality' && !action" :document="document"></quality-content>
  <quality-form v-else-if="collection === 'quality' && action === 'quality-write'" :document="document" :action="action"></quality-form>
  <quality-article-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'iso'" :document="document" :action="action"></quality-article-form>
  <quality-rohs-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'rohs'" :document="document" :action="action"></quality-rohs-form>
  <quality-ncr-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'ncr'" :document="document" :action="action"></quality-ncr-form>
  <quality-qmr-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'qmr'" :document="document" :action="action"></quality-qmr-form>
  <quality-pqcsheet-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'pqcsheet'" :document="document" :action="action"></quality-pqcsheet-form>
  <quality-4m-form v-else-if="collection === 'quality' && action === 'article-write' && document === '4m'" :document="document" :action="action"></quality-4m-form>
  <quality-reliability-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'reliability'" :document="document" :action="action"></quality-reliability-form>
  <production-content v-else-if="collection === 'production' && !action" :document="document"></production-content>
  <production-form v-else-if="collection === 'production' && action === 'production-write'" :document="document" :action="action"></production-form>
  <Production-mlist-form v-else-if="collection === 'production' && action === 'article-write' && document === 'machine-list'" :document= "document" :action="action"></Production-mlist-form>
  <Production-plan-form v-else-if="collection === 'production' && action === 'article-write' && document === 'plan'" :document= "document" :action="action"></Production-plan-form>
  <Production-package-form v-else-if="collection === 'production' && action === 'article-write' && document === 'package'" :document= "document" :action="action"></Production-package-form>
  <Production-worksheet-form v-else-if="collection === 'production' && action === 'article-write' && document === 'worksheet'" :document= "document" :action="action"></Production-worksheet-form>
  <rnd-content v-else-if="collection === 'rnd' && !action" :document="document"></rnd-content>
  <rnd-form v-else-if="collection === 'rnd' && action === 'rnd-write'" :document="document" :action="action"></rnd-form>
  <rnd-drawing-form v-else-if="collection === 'rnd' && action === 'article-write' && document === 'drawing'" :document= "document" :action="action"></rnd-drawing-form>
  <error-page v-else></error-page>
</template>
<script>
import QualityContent from './quality/content'
import QualityForm from './quality/form'
import QualityArticleForm from './quality/article/form'
import QualityRohsForm from './quality/rohs/form'
import QualityNcrForm from './quality/ncr/form'
import QualityQmrForm from './quality/qmr/form'
import QualityPqcsheetForm from './quality/pqcsheet/form'
import Quality4mForm from './quality/4m/form'
import QualityReliabilityForm from './quality/reliability/form'
import ProductionContent from './production/content'
import ProductionForm from './production/form'
import ProductionMlistForm from './production/mlist/form'
import ProductionPlanForm from './production/plan/form'
import ProductionPackageForm from './production/package/form'
import ProductionWorksheetForm from './production/worksheet/form'
import RndContent from './rnd/content'
import RndForm from './rnd/form'
import RndDrawingForm from './rnd/drawing/form'
import ErrorPage from './error'
export default {
  components: {
    QualityContent,
    QualityForm,
    QualityArticleForm,
    QualityRohsForm,
    QualityNcrForm,
    QualityQmrForm,
    QualityPqcsheetForm,
    Quality4mForm,
    QualityReliabilityForm,
    ProductionContent,
    ProductionForm,
    ProductionMlistForm,
    ProductionPlanForm,
    ProductionPackageForm,
    ProductionWorksheetForm,
    RndContent,
    RndForm,
    RndDrawingForm,
    ErrorPage
  },
  computed: {
    collection () {
      return this.$route.params.collection
    },
    document () {
      return this.$route.params.document
    },
    action () {
      return this.$route.params.action
    }
  }
}
</script>
