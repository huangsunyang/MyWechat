// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: MWNetworkData.proto

#ifndef PROTOBUF_MWNetworkData_2eproto__INCLUDED
#define PROTOBUF_MWNetworkData_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 3004000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 3004000 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_table_driven.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/metadata.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)
class MWNetworkData;
class MWNetworkDataDefaultTypeInternal;
extern MWNetworkDataDefaultTypeInternal _MWNetworkData_default_instance_;

namespace protobuf_MWNetworkData_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::internal::ParseTableField entries[];
  static const ::google::protobuf::internal::AuxillaryParseTableField aux[];
  static const ::google::protobuf::internal::ParseTable schema[];
  static const ::google::protobuf::uint32 offsets[];
  static const ::google::protobuf::internal::FieldMetadata field_metadata[];
  static const ::google::protobuf::internal::SerializationTable serialization_table[];
  static void InitDefaultsImpl();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_MWNetworkData_2eproto

// ===================================================================

class MWNetworkData : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:MWNetworkData) */ {
 public:
  MWNetworkData();
  virtual ~MWNetworkData();

  MWNetworkData(const MWNetworkData& from);

  inline MWNetworkData& operator=(const MWNetworkData& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  MWNetworkData(MWNetworkData&& from) noexcept
    : MWNetworkData() {
    *this = ::std::move(from);
  }

  inline MWNetworkData& operator=(MWNetworkData&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  static const ::google::protobuf::Descriptor* descriptor();
  static const MWNetworkData& default_instance();

  static inline const MWNetworkData* internal_default_instance() {
    return reinterpret_cast<const MWNetworkData*>(
               &_MWNetworkData_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    0;

  void Swap(MWNetworkData* other);
  friend void swap(MWNetworkData& a, MWNetworkData& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline MWNetworkData* New() const PROTOBUF_FINAL { return New(NULL); }

  MWNetworkData* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const MWNetworkData& from);
  void MergeFrom(const MWNetworkData& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(MWNetworkData* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // string str_data = 2;
  void clear_str_data();
  static const int kStrDataFieldNumber = 2;
  const ::std::string& str_data() const;
  void set_str_data(const ::std::string& value);
  #if LANG_CXX11
  void set_str_data(::std::string&& value);
  #endif
  void set_str_data(const char* value);
  void set_str_data(const char* value, size_t size);
  ::std::string* mutable_str_data();
  ::std::string* release_str_data();
  void set_allocated_str_data(::std::string* str_data);

  // string from_usr = 3;
  void clear_from_usr();
  static const int kFromUsrFieldNumber = 3;
  const ::std::string& from_usr() const;
  void set_from_usr(const ::std::string& value);
  #if LANG_CXX11
  void set_from_usr(::std::string&& value);
  #endif
  void set_from_usr(const char* value);
  void set_from_usr(const char* value, size_t size);
  ::std::string* mutable_from_usr();
  ::std::string* release_from_usr();
  void set_allocated_from_usr(::std::string* from_usr);

  // string to_usr = 4;
  void clear_to_usr();
  static const int kToUsrFieldNumber = 4;
  const ::std::string& to_usr() const;
  void set_to_usr(const ::std::string& value);
  #if LANG_CXX11
  void set_to_usr(::std::string&& value);
  #endif
  void set_to_usr(const char* value);
  void set_to_usr(const char* value, size_t size);
  ::std::string* mutable_to_usr();
  ::std::string* release_to_usr();
  void set_allocated_to_usr(::std::string* to_usr);

  // int32 type = 1;
  void clear_type();
  static const int kTypeFieldNumber = 1;
  ::google::protobuf::int32 type() const;
  void set_type(::google::protobuf::int32 value);

  // @@protoc_insertion_point(class_scope:MWNetworkData)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::internal::ArenaStringPtr str_data_;
  ::google::protobuf::internal::ArenaStringPtr from_usr_;
  ::google::protobuf::internal::ArenaStringPtr to_usr_;
  ::google::protobuf::int32 type_;
  mutable int _cached_size_;
  friend struct protobuf_MWNetworkData_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
#ifdef __GNUC__
  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif  // __GNUC__
// MWNetworkData

// int32 type = 1;
inline void MWNetworkData::clear_type() {
  type_ = 0;
}
inline ::google::protobuf::int32 MWNetworkData::type() const {
  // @@protoc_insertion_point(field_get:MWNetworkData.type)
  return type_;
}
inline void MWNetworkData::set_type(::google::protobuf::int32 value) {
  
  type_ = value;
  // @@protoc_insertion_point(field_set:MWNetworkData.type)
}

// string str_data = 2;
inline void MWNetworkData::clear_str_data() {
  str_data_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& MWNetworkData::str_data() const {
  // @@protoc_insertion_point(field_get:MWNetworkData.str_data)
  return str_data_.GetNoArena();
}
inline void MWNetworkData::set_str_data(const ::std::string& value) {
  
  str_data_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:MWNetworkData.str_data)
}
#if LANG_CXX11
inline void MWNetworkData::set_str_data(::std::string&& value) {
  
  str_data_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:MWNetworkData.str_data)
}
#endif
inline void MWNetworkData::set_str_data(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  str_data_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:MWNetworkData.str_data)
}
inline void MWNetworkData::set_str_data(const char* value, size_t size) {
  
  str_data_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:MWNetworkData.str_data)
}
inline ::std::string* MWNetworkData::mutable_str_data() {
  
  // @@protoc_insertion_point(field_mutable:MWNetworkData.str_data)
  return str_data_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* MWNetworkData::release_str_data() {
  // @@protoc_insertion_point(field_release:MWNetworkData.str_data)
  
  return str_data_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void MWNetworkData::set_allocated_str_data(::std::string* str_data) {
  if (str_data != NULL) {
    
  } else {
    
  }
  str_data_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), str_data);
  // @@protoc_insertion_point(field_set_allocated:MWNetworkData.str_data)
}

// string from_usr = 3;
inline void MWNetworkData::clear_from_usr() {
  from_usr_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& MWNetworkData::from_usr() const {
  // @@protoc_insertion_point(field_get:MWNetworkData.from_usr)
  return from_usr_.GetNoArena();
}
inline void MWNetworkData::set_from_usr(const ::std::string& value) {
  
  from_usr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:MWNetworkData.from_usr)
}
#if LANG_CXX11
inline void MWNetworkData::set_from_usr(::std::string&& value) {
  
  from_usr_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:MWNetworkData.from_usr)
}
#endif
inline void MWNetworkData::set_from_usr(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  from_usr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:MWNetworkData.from_usr)
}
inline void MWNetworkData::set_from_usr(const char* value, size_t size) {
  
  from_usr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:MWNetworkData.from_usr)
}
inline ::std::string* MWNetworkData::mutable_from_usr() {
  
  // @@protoc_insertion_point(field_mutable:MWNetworkData.from_usr)
  return from_usr_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* MWNetworkData::release_from_usr() {
  // @@protoc_insertion_point(field_release:MWNetworkData.from_usr)
  
  return from_usr_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void MWNetworkData::set_allocated_from_usr(::std::string* from_usr) {
  if (from_usr != NULL) {
    
  } else {
    
  }
  from_usr_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), from_usr);
  // @@protoc_insertion_point(field_set_allocated:MWNetworkData.from_usr)
}

// string to_usr = 4;
inline void MWNetworkData::clear_to_usr() {
  to_usr_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& MWNetworkData::to_usr() const {
  // @@protoc_insertion_point(field_get:MWNetworkData.to_usr)
  return to_usr_.GetNoArena();
}
inline void MWNetworkData::set_to_usr(const ::std::string& value) {
  
  to_usr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:MWNetworkData.to_usr)
}
#if LANG_CXX11
inline void MWNetworkData::set_to_usr(::std::string&& value) {
  
  to_usr_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:MWNetworkData.to_usr)
}
#endif
inline void MWNetworkData::set_to_usr(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  to_usr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:MWNetworkData.to_usr)
}
inline void MWNetworkData::set_to_usr(const char* value, size_t size) {
  
  to_usr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:MWNetworkData.to_usr)
}
inline ::std::string* MWNetworkData::mutable_to_usr() {
  
  // @@protoc_insertion_point(field_mutable:MWNetworkData.to_usr)
  return to_usr_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* MWNetworkData::release_to_usr() {
  // @@protoc_insertion_point(field_release:MWNetworkData.to_usr)
  
  return to_usr_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void MWNetworkData::set_allocated_to_usr(::std::string* to_usr) {
  if (to_usr != NULL) {
    
  } else {
    
  }
  to_usr_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), to_usr);
  // @@protoc_insertion_point(field_set_allocated:MWNetworkData.to_usr)
}

#ifdef __GNUC__
  #pragma GCC diagnostic pop
#endif  // __GNUC__
#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS

// @@protoc_insertion_point(namespace_scope)


// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_MWNetworkData_2eproto__INCLUDED
