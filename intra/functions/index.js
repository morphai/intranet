const functions = require('firebase-functions')
var admin = require('firebase-admin')
var serviceAccount = require('./key.json')

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: functions.config().admin.db_url // 'https://memi-vf2.firebaseio.com'
})

const db = admin.database()
const fdb = admin.firestore()

exports.createUser = functions.auth.user().onCreate(async (user) => {
  const { uid, email, displayName, photoURL } = user
  const time = new Date()
  const u = {
    email,
    displayName,
    photoURL,
    createdAt: time,
    level: email === functions.config().admin.email ? 0 : 10
  }
  await fdb.collection('users').doc(uid).set(u)
  u.createdAt = time.getTime()
  await db.ref('users').child(uid).set(u)
})

exports.deleteUser = functions.auth.user().onDelete(async (user) => {
  const { uid } = user
  await db.ref('users').child(uid).remove()
  await fdb.collection('users').doc(uid).delete()
})

exports.incrementQualityCount = functions.firestore.document('quality/{bid}').onCreate(async (snap, context) => {
  try {
    await fdb.collection('meta').doc('quality').update('count', admin.firestore.FieldValue.increment(1))
  } catch (e) {
    await fdb.collection('meta').doc('quality').set({ count: 1 })
  }
})

exports.decrementQualityCount = functions.firestore.document('quality/{bid}').onDelete(async (snap, context) => {
  await fdb.collection('meta').doc('quality').update('count', admin.firestore.FieldValue.increment(-1))
})

exports.incrementProductionCount = functions.firestore.document('production/{bid}').onCreate(async (snap, context) => {
  try {
    await fdb.collection('meta').doc('production').update('count', admin.firestore.FieldValue.increment(1))
  } catch (e) {
    await fdb.collection('meta').doc('production').set({ count: 1 })
  }
})

exports.decrementProductionCount = functions.firestore.document('production/{bid}').onDelete(async (snap, context) => {
  await fdb.collection('meta').doc('production').update('count', admin.firestore.FieldValue.increment(-1))
})

exports.incrementMoldCount = functions.firestore.document('mold/{bid}').onCreate(async (snap, context) => {
  try {
    await fdb.collection('meta').doc('mold').update('count', admin.firestore.FieldValue.increment(1))
  } catch (e) {
    await fdb.collection('meta').doc('mold').set({ count: 1 })
  }
})

exports.decrementMoldCount = functions.firestore.document('mold/{bid}').onDelete(async (snap, context) => {
  await fdb.collection('meta').doc('mold').update('count', admin.firestore.FieldValue.increment(-1))
})

exports.incrementRndCount = functions.firestore.document('rnd/{bid}').onCreate(async (snap, context) => {
  try {
    await fdb.collection('meta').doc('rnd').update('count', admin.firestore.FieldValue.increment(1))
  } catch (e) {
    await fdb.collection('meta').doc('rnd').set({ count: 1 })
  }
})

exports.decrementRndCount = functions.firestore.document('rnd/{bid}').onDelete(async (snap, context) => {
  await fdb.collection('meta').doc('rnd').update('count', admin.firestore.FieldValue.increment(-1))
})

exports.incrementSpcCount = functions.firestore.document('spc/{bid}').onCreate(async (snap, context) => {
  try {
    await fdb.collection('meta').doc('spc').update('count', admin.firestore.FieldValue.increment(1))
  } catch (e) {
    await fdb.collection('meta').doc('spc').set({ count: 1 })
  }
})

exports.decrementSpcCount = functions.firestore.document('spc/{bid}').onDelete(async (snap, context) => {
  await fdb.collection('meta').doc('spc').update('count', admin.firestore.FieldValue.increment(-1))
})