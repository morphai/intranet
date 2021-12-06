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
  <quality-pfmea-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'pfmea'" :document="document" :action="action"></quality-pfmea-form>
  <quality-certification-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'certification'" :document="document" :action="action"></quality-certification-form>
  <quality-iqc-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'iqc'" :document="document" :action="action"></quality-iqc-form>
  <quality-pqc-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'pqc'" :document="document" :action="action"></quality-pqc-form>
  <quality-oqc-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'oqc'" :document="document" :action="action"></quality-oqc-form>
  <quality-incomingReport-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'incomingReport'" :document="document" :action="action"></quality-incomingReport-form>
  <quality-outgoingReport-form v-else-if="collection === 'quality' && action === 'article-write' && document === 'outgoingReport'" :document="document" :action="action"></quality-outgoingReport-form>
  <production-content v-else-if="collection === 'production' && !action" :document="document"></production-content>
  <production-form v-else-if="collection === 'production' && action === 'production-write'" :document="document" :action="action"></production-form>
  <Production-mlist-form v-else-if="collection === 'production' && action === 'article-write' && document === 'machine-list'" :document= "document" :action="action"></Production-mlist-form>
  <Production-plan-form v-else-if="collection === 'production' && action === 'article-write' && document === 'plan'" :document= "document" :action="action"></Production-plan-form>
  <Production-package-form v-else-if="collection === 'production' && action === 'article-write' && document === 'package'" :document= "document" :action="action"></Production-package-form>
  <Production-worksheet-form v-else-if="collection === 'production' && action === 'article-write' && document === 'worksheet'" :document= "document" :action="action"></Production-worksheet-form>
  <rnd-content v-else-if="collection === 'rnd' && !action" :document="document"></rnd-content>
  <rnd-form v-else-if="collection === 'rnd' && action === 'rnd-write'" :document="document" :action="action"></rnd-form>
  <rnd-drawing-form v-else-if="collection === 'rnd' && action === 'article-write' && document === 'drawing'" :document= "document" :action="action"></rnd-drawing-form>
  <rnd-approval-form v-else-if="collection === 'rnd' && action === 'article-write' && document === 'approval'" :document= "document" :action="action"></rnd-approval-form>
  <rnd-dfmea-form v-else-if="collection === 'rnd' && action === 'article-write' && document === 'dfmea'" :document= "document" :action="action"></rnd-dfmea-form>
  <rnd-meeting-form v-else-if="collection === 'rnd' && action === 'article-write' && document === 'meeting'" :document= "document" :action="action"></rnd-meeting-form>
  <mold-content v-else-if="collection === 'mold' && !action" :document="document"></mold-content>
  <mold-form v-else-if="collection === 'mold' && action === 'mold-write'" :document="document" :action="action"></mold-form>
  <mold-repair-form v-else-if="collection === 'mold' && action === 'article-write' && document === 'repair'" :document= "document" :action="action"></mold-repair-form>
  <mold-tooling-form v-else-if="collection === 'mold' && action === 'article-write' && document === 'tooling'" :document= "document" :action="action"></mold-tooling-form>
  <mold-shot-form v-else-if="collection === 'mold' && action === 'article-write' && document === 'shot'" :document= "document" :action="action"></mold-shot-form>
  <spc-content v-else-if="collection === 'spc' && !action" :document="document"></spc-content>
  <spc-form v-else-if="collection === 'spc' && action === 'spc-write'" :document="document" :action="action"></spc-form>
  <spc-pqc-form v-else-if="collection === 'spc' && action === 'article-write' && document === 'pqc'" :document= "document" :action="action"></spc-pqc-form>
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
import QualityPfmeaForm from './quality/pfmea/form'
import QualityCertificationForm from './quality/certification/form'
import QualityIqcForm from './quality/iqc/form'
import QualityPqcForm from './quality/pqc/form'
import QualityOqcForm from './quality/oqc/form'
import QualityIncomingReportForm from './quality/incomingReport/form'
import QualityOutgoingReportForm from './quality/outgoingReport/form'
import ProductionContent from './production/content'
import ProductionForm from './production/form'
import ProductionMlistForm from './production/mlist/form'
import ProductionPlanForm from './production/plan/form'
import ProductionPackageForm from './production/package/form'
import ProductionWorksheetForm from './production/worksheet/form'
import RndContent from './rnd/content'
import RndForm from './rnd/form'
import RndDrawingForm from './rnd/drawing/form'
import RndApprovalForm from './rnd/approval/form'
import RndDfmeaForm from './rnd/dfmea/form'
import RndMeetingForm from './rnd/meeting/form'
import MoldContent from './mold/content'
import MoldForm from './mold/form'
import MoldRepairForm from './mold/repair/form'
import MoldToolingForm from './mold/tooling/form'
import MoldShotForm from './mold/shot/form'
import SpcContent from './spc/content'
import SpcForm from './spc/form'
import SpcPqcForm from './spc/pqc/form'
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
    QualityPfmeaForm,
    QualityCertificationForm,
    QualityIqcForm,
    QualityPqcForm,
    QualityOqcForm,
    QualityIncomingReportForm,
    QualityOutgoingReportForm,
    ProductionContent,
    ProductionForm,
    ProductionMlistForm,
    ProductionPlanForm,
    ProductionPackageForm,
    ProductionWorksheetForm,
    RndContent,
    RndForm,
    RndDrawingForm,
    RndApprovalForm,
    RndDfmeaForm,
    RndMeetingForm,
    MoldContent,
    MoldForm,
    MoldRepairForm,
    MoldToolingForm,
    MoldShotForm,
    SpcContent,
    SpcForm,
    SpcPqcForm,
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
