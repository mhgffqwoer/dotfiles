#include <cassert>
#include <iostream>

template <typename T>
class CPosibleHasValue {
   private:
    T value_;
    bool has_value_;

   public:
    CPosibleHasValue() : value_(), has_value_(false) {}

    explicit CPosibleHasValue(const T& val) : value_(val), has_value_(true) {}

    explicit CPosibleHasValue(const CPosibleHasValue& other)
        : value_(other.value_), has_value_(other.has_value_) {}

    explicit CPosibleHasValue(CPosibleHasValue&& other)
        : value_(std::move(other.value_)), has_value_(other.has_value_) {}

    CPosibleHasValue& operator=(const CPosibleHasValue& other) {
        value_ = other.value_;
        has_value_ = other.has_value_;
        return *this;
    }

    CPosibleHasValue& operator=(CPosibleHasValue&& other) {
        value_ = std::move(other.value_);
        has_value_ = other.has_value_;
        return *this;
    }

    ~CPosibleHasValue() = default;

    T value() const {
        if (!has_value_) {
            throw std::runtime_error("No-value");
            exit(EXIT_FAILURE);
        }
        return value_;
    }

    bool has_value() const { return has_value_; }
};

int main(void) {
    // std deprecated
    CPosibleHasValue<int> pv;
    assert(!pv.has_value());

    CPosibleHasValue<int> pv2{1};
    assert(pv2.has_value());
    assert(pv2.value() == 1);

    // std::cout << pv2.value() << "\n";
    // std::cout << pv.value() << "\n";

    const CPosibleHasValue<int> pv3{1};
    assert(pv3.has_value());
    assert(pv3.value() == 1);

    return 0;
}
